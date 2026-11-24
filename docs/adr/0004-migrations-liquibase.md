---
status: accepté
date: 2026-11-20
domaine: Données
sections-cdc: "7.1, 7.3"
source: https://app.notion.com/p/41eb1edbc9ba8193a1abfc7faa4d828d
---

# ADR-4 : Migrations de schéma avec Liquibase

**Décision** : Changelogs Liquibase en YAML appliqués au démarrage ; Hibernate en mode validate uniquement

## Contexte

Le schéma PostgreSQL doit évoluer de façon versionnée, reproductible en local, en CI (Testcontainers) et en production.

## Options étudiées

1. Génération automatique par Hibernate (`ddl-auto=update`) : rapide mais non maîtrisée, dangereuse en production
2. Flyway : migrations SQL numérotées, très simple
3. Liquibase : changesets YAML / XML / SQL, rollback, préconditions, commentaires de colonnes

## Décision

Liquibase avec un changelog maître `db/changelog/db.changelog-master.yaml` et des changesets YAML, appliqués automatiquement au démarrage du backend. Hibernate est configuré en `validate` : il vérifie le schéma mais ne le modifie jamais.

## Conséquences

- ✅ Historique complet du schéma dans Git, revu en PR
- ✅ Les `remarks` des changesets alimentent la documentation générée par tbls (ADR-16)
- ⚠️ Un changeset appliqué ne se modifie plus : toute correction passe par un nouveau changeset
- 🤖 Skill `/new-changeset` pour que l'agent respecte les conventions
