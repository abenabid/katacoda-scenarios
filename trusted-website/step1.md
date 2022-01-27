Afin de vérifier que la signature d'un certificat est authentique, on utilise la clé publique de l'Autorité de Certification.

Les éditeurs des systèmes d'exploitation et certain editeurs des navigateurs Web ont regroupé toutes les certifcats des Autorités de Certification auquels ils font confiance dans des "magasins de certificat".

L'environnement Java adopte aussi son propre magasin de certificat appellé Truststore.

Dans notre exemple, le Truststore est situé au chemin suivant:

`/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts`

Afin de manipuler ce type de fichier, on utilise souvent la commande `keytool`

### Objectifs

Avec la commande keytool, afficher l'ensemble des certificats disponibles dans le Truststore

Pour information, le Truststore est protégé par un mot de passe par défaut: `changeit`