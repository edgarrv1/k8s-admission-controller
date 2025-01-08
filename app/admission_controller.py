from flask import Flask, request, jsonify


admission_controller = Flask(__name__)


@admission_controller.route('/validate/deployments', methods=['POST'])
def deployment_webhook():
    request_info = request.get_json()
    if request_info["request"]["object"]["spec"]["template"]["spec"]["containers"][0]["securityContext"]["runAsUser"] != 0:
        return admission_response(True, "Container not running as Root")
    return admission_response(False, "Containers are not allowed to run as Root")


def admission_response(allowed, message):
    return jsonify({"response": {"allowed": allowed, "status": {"message": message}}})


if __name__ == '__main__':
    admission_controller.run(host='0.0.0.0', port=8443, ssl_context=("/run/secrets/tls/Admission-Controller-TLS.crt", "/run/secrets/tls/Admission-Controller-TLS.key"))
