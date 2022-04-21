#!/bin/sh

CERTS_DIR="${CERTS_DIR:-"/etc/certs"}"

generate_certificate()
{
  [ ! -d "$CERTS_DIR" ] && mkdir -p "$CERTS_DIR"

  # Build Open SSL conf
  [ -f "$CERTS_DIR/openssl.cnf" ] && rm "$CERTS_DIR/openssl.cnf"
  cat > "$CERTS_DIR/openssl.cnf" << EOF
[dn]
CN=localhost
[req]
distinguished_name = dn
[EXT]
keyUsage=digitalSignature
extendedKeyUsage=serverAuth
[alt_names]
EOF
  ITER=1
  for i in $(echo $APP_HOSTS | sed "s/;/ /g")
  do
    echo "DNS.$ITER=$i" >> "$CERTS_DIR/openssl.cnf"
    ITER=$(expr $ITER + 1)
  done

  # Generate certificate
  openssl req -x509 -days 365 -newkey rsa:4096 -nodes -sha256 -subj "/C=FR/ST=FRANCE/L=TOULOUSE/O=ClEVERAGE/OU=PRESENCE/CN=$APP_HOST_MAIN" -extensions EXT -config "$CERTS_DIR/openssl.cnf" -out "$CERTS_DIR/server.crt" -keyout $CERTS_DIR/server.key""
}

if [ -f "$CERTS_DIR/server.key" ] &&  [ -f "$CERTS_DIR/server.crt" ]
then
    EXPIRATION_DATE=$( openssl x509 -enddate -noout -in $CERTS_DIR/server.crt | sed 's/notAfter=//')
    EXPIRATION_TIMESTAMP=$( date --date="$EXPIRATION_DATE" +%s)
    NOW_TIMESTAMP=$( date +%s)
    if [ $EXPIRATION_TIMESTAMP -le $NOW_TIMESTAMP ];
    then
      echo "Expired certificates, regenerating them ..."
      generate_certificate
    fi
else
    echo "Generating certificates ..."
    generate_certificate
fi