# Autopartage Web Sites

## Description:
Application Web d'autopartage.

## Auteurs / Authors:
- Wassim Hamadache
- Marsel Bakashov

## Pour utiliser l'application...
- Assurez-vous d'avoir installé PostgreSQL.
- Assurez-vous d'avoir installé Node.
- Allez dans `/client` et lancez la commande `npm ci` dans un terminal.
- Allez dans `/server` et lancez la commande `npm ci` dans un terminal.
- Allez dans `/server/app/services/database.service.ts` et modifiez `connectionConfig` avec les bons paramètres de votre BD. 
- Sur PGAdmin, cliquez sur Query Tool et ouvrez le fichier bdschema.sql fourni et lancez-le.
- Insérez les données en répétant l'étape précédente avec le fichier data.sql fourni.
- Allez dans `/client` et lancez la commande `npm start` dans un terminal. (Si une question vous est posé dans le terminal, entrez 'n')
- Allez dans `/server` et lancez la commande `npm start` dans un terminal.

## Exemple de configuration :

- Créez une base de données (le nom de votre choix) et postgres comme user
- Définissez le mot de passe de postgres à root (Login/Group Roles -> Click droit sur postgres -> Properties -> Definition)
- Respectez cette configuration pour la db dans VS Code dans le fichier `database.service.ts`
- user: "postgres",
- database: NOM DE LA DATABASE,
- password: "root",
- port: 5432,
- host: "127.0.0.1",
- keepAlive: true,
- Allez dans `/server` et faites la commande `npm start` dans un terminal. Le serveur est lancé au `localhost:3000` par défaut.
- Allez dans `/client` et faites la commande `npm start` dans un terminal. Le client est lancé au `localhost:4200` par défaut.
