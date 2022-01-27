Une fois le programme est compilé, on peut commencer à le tester.

Voici comment le lancer:

`java URLConnectionReader <URL>`

### Exemples:
#### Exemple 1
`java URLConnectionReader https://www.google.fr`{{execute}}

Si tous fonctionne correctement, on obtient le code source de la page d'accueil de Google.fr

#### Exemple 2
Essayons maintenant une autre addresse: `https://self-signed.badssl.com`

`java URLConnectionReader https://self-signed.badssl.com`{{execute}}

Celle-ci utilise un certificat signé par une Autorité de Certification inconue à Java. Par conséquent, l'exécution du programme est interrompue par une erreur.