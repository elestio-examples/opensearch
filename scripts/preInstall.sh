echo 'vm.max_map_count=512000' >> /etc/sysctl.conf && sysctl -p

mkdir -p ./data;
chown -R 1000:1000 ./data;


openssl genrsa -out ./data/root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key ./data/root-ca-key.pem -out ./data/root-ca.pem -days 3650 -subj "/CN=${DOMAIN}"

# Add the required configuration to opensearch.yml
cat <<EOF >> ./opensearch.yml
plugins:
  security:
    ssl:
      transport.enforce_hostname_verification: false
      http.enabled: true
      http.pemtrustedcas_filepath: root-ca.pem
    authcz:
      admin_dn:
        - 'CN=${DOMAIN}'
    nodes_dn:
      - 'CN=${DOMAIN}'
EOF