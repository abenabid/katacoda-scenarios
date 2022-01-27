Afin de lister le contenu du Truststore, on peut utiliser la commande suivante:

`keytool -list -cacerts`{{execute}}

On peut ajouter l'option `-v` pour plus de détails

`keytool -list -cacerts -v`{{execute}}

Pour information, le Truststore est protégé par un mot de passe par défaut: `changeit`