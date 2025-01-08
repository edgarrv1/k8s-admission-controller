#!/bin/bash
CERT_DIR="./tls"
CA_NAME="Admission_Controller_CA"
TLS_CERT_NAME="Admission-Controller-TLS"
SERVER_CERT_LIFESPAN=365
CA_CERT_LIFESPAN=3650
KEY_SIZE=2048

mkdir -p "$CERT_DIR"

#create CA key
openssl genrsa -out "$CERT_DIR/$CA_NAME.key" $KEY_SIZE
#create CA
openssl req -x509 -new -nodes -key "$CERT_DIR/$CA_NAME.key" -sha256 -days $CA_CERT_LIFESPAN \
  -subj "/CN=Admission Controller CA" \
  -out "$CERT_DIR/$CA_NAME.crt"

#create tls server key
openssl genrsa -out "$CERT_DIR/$TLS_CERT_NAME.key" $KEY_SIZE
#create tls server csr

#admission-controller-server.admission-controller-namespace.svc
openssl req -new -key "$CERT_DIR/$TLS_CERT_NAME.key" \
  -subj "/CN=127.0.0.1" \
  -out "$CERT_DIR/$TLS_CERT_NAME.csr"

#sign tls server csr
openssl x509 -req -in "$CERT_DIR/$TLS_CERT_NAME.csr" -CA "$CERT_DIR/$CA_NAME.crt" -CAkey "$CERT_DIR/$CA_NAME.key" \
  -CAcreateserial -out "$CERT_DIR/$TLS_CERT_NAME.crt" -days $SERVER_CERT_LIFESPAN -sha256

#create tls bundle
cat "$CERT_DIR/$TLS_CERT_NAME.crt" "$CERT_DIR/$CA_NAME.crt" > "$CERT_DIR/$TLS_CERT_NAME-ca-bundle.crt"
#cleanup csr
rm -f "$CERT_DIR/$TLS_CERT_NAME.csr"


