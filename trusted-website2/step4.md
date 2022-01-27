Si on décide de faire confiance au certificat de `self-signed.badssl.com`, il est possible de l'ajouter dans le Keystore.

Tout d'abord, il faut récupérer le certifcat.

On peut utiliser la commande `openssl`, voici un exemple:
`echo | openssl s_client -connect <DOMAINE>:443  2>/dev/null | openssl x509 > certificat.pem`

Ensuite, on ajoute ce certificat dans le Truststore à l'aide de la commande `keytool` tout en lui donnant un alias permettant de l'identifier facilement.

`keytool -import -cacerts -file certificat.pem -alias self-signed-badssl`

Il faut répondre par `yes` à la question `Trust this certificate?`


