---
status: accepté
date: 2026-11-20
domaine: Données
sections-cdc: "7.1, 7.3"
source: https://app.notion.com/p/41eb1edbc9ba817582b8d7362b64bf79
---

# ADR-7 : PostgreSQL 16 auto-hébergé sur le VPS

**Décision** : PostgreSQL 16 en conteneur sur le VPS, réseau Docker interne, pg_dump quotidien copié hors du VPS

## Contexte

Les offres PostgreSQL gratuites ou peu chères imposent des limites (taille, connexions, mise en veille). Le volume de données relationnelles reste modéré, les médias étant stockés ailleurs.

## Options étudiées

1. PostgreSQL managé à offre gratuite (BaaS, serverless) : limites et dépendance
2. PostgreSQL managé payant européen : fiable mais plus cher que le VPS lui-même
3. PostgreSQL auto-hébergé sur le VPS

## Décision

Option 3 : PostgreSQL 16 en conteneur, données sur un volume persistant, port 5432 jamais exposé (accès d'administration par tunnel SSH), connexion directe via HikariCP. Sauvegarde nocturne `pg_dump`, rétention 7 jours / 4 semaines / 3 mois, copie hors du VPS avec rclone, test de restauration mensuel.

## Conséquences

- ✅ Aucune limite de taille ni de connexions, aucun coût supplémentaire
- ⚠️ Sauvegardes et restaurations à la charge du développeur
- 🔁 Évolution possible : WAL-G ou pgBackRest, ou PostgreSQL managé européen si la charge l'exige
