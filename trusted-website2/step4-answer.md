Pour récupérer le certificat:
`echo | openssl s_client -connect self-signed.badssl.com:443  2>/dev/null | openssl x509 > certificat.pem`{{execute}}

Pour ajouter le certificat au Truststore
`keytool -import -cacerts -file certificat.pem -alias self-signed-badssl`{{execute}}

Pour afficher le certificat qu'on vient d'ajouter:
`keytool -list -cacerts -alias self-signed-badssl`{{execute}}