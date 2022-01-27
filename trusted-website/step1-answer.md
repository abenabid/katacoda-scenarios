Afin de lister le contenu du Truststore, on peut utiliser la commande suivante:

`keytool -list -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts `{{execute}}

On peut ajouter l'option `-v` pour plus de détails

`keytool -list -v -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts `{{execute}}
