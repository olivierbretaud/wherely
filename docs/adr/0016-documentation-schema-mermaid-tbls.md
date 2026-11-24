---
status: accepté
date: 2026-11-20
domaine: Données
sections-cdc: "7.4, 7.6"
source: https://app.notion.com/p/41eb1edbc9ba8117b3fbd44a20e61853
---

# ADR-16 : Documentation du schéma : diagramme Mermaid et tbls

**Décision** : Modèle de conception en Mermaid (docs/database/model.md) et schéma réel généré par tbls depuis Liquibase, contrôlé en CI par tbls diff

## Contexte

Le diagramme de la base doit rester à jour au fil du développement et pouvoir être modifié par Claude Code dans l'IDE comme dans Notion.

## Options étudiées

1. Diagrammes visuels d'outils de base de données (DBeaver, IntelliJ) : non textuels, impossibles à tenir à jour par un agent
2. DBML (dbdiagram.io) : textuel mais peu affiché nativement
3. Mermaid `erDiagram` : textuel, affiché par GitHub, Notion et l'IDE
4. tbls : documentation générée depuis la vraie base

## Décision

Deux niveaux :

- Modèle de conception en Mermaid, dans le cahier des charges (7.4) et `docs/database/model.md`, mis à jour à chaque décision
- Schéma réel généré par tbls (`just db-docs` : PostgreSQL temporaire, changesets Liquibase, `tbls doc`) dans `docs/database/schema/`, contrôlé en CI par `tbls diff`

## Conséquences

- ✅ Le schéma documenté ne peut pas dériver du schéma réel
- ✅ Skill `/new-changeset` et serveur MCP PostgreSQL en lecture seule pour l'agent
- ⚠️ Le modèle de conception, écrit à la main, peut prendre du retard : le schéma généré fait foi
