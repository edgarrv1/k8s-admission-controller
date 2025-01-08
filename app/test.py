import json

object = {
    "request": {
      "uid": "example-uid",
      "kind": "AdmissionReview",
      "resource": {
        "group": "apps",
        "version": "v1",
        "resource": "deployments"
      },
      "object": {
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
          "name": "example-deployment",
          "namespace": "default",
          "labels": {
            "app": "example"
          }
        },
        "spec": {
          "replicas": 1,
          "selector": {
            "matchLabels": {
              "app": "example"
            }
          },
          "template": {
            "metadata": {
              "labels": {
                "app": "example"
              }
            },
            "spec": {
              "containers": [
                {
                  "name": "example-container",
                  "image": "nginx:latest",
                  "securityContext": {
                    "runAsUser": 0  
                  }
                }
              ]
            }
          }
        }
      },
      "oldObject": "null"
    }
  }
  
if object["request"]["object"]["spec"]["template"]["spec"]["containers"][0]["securityContext"]["runAsUser"] != 1:
    print("root")


# if object["request"]["object"]["spec"]["template"]["spec"]["containers"]["securityContext"]["runAsUser"]:
#     print('works')