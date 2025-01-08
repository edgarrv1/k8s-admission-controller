kubectl -n admission-controller-namespace create secret tls admission-controller-tls-secret \
    --cert "./tls/Admission-Controller-TLS.crt" \
    --key "./tls/Admission-Controller-TLS.key"