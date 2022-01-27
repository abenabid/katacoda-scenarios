Vérifions maintenant si Java accepte de consulter l'URL `https://self-signed.badssl.com`

`java URLConnectionReader https://self-signed.badssl.com`{execute}

Si tout fonctionne correctement, on obtient le code source de la page web.