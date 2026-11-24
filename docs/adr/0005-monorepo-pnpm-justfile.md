---
status: accepté
date: 2026-11-20
domaine: Organisation
sections-cdc: "7.6"
source: https://app.notion.com/p/41eb1edbc9ba8158bb21c8b02d30d5cd
---

# ADR-5 : Monorepo avec pnpm workspaces et justfile

**Décision** : Un seul dépôt (apps/api, apps/web, packages, contracts, infra, docs), pnpm workspaces pour le JavaScript, justfile pour les commandes communes

## Contexte

Une fonctionnalité touche souvent l'API, le contrat OpenAPI, les types générés et le front. Le projet sert aussi de terrain d'apprentissage du développement agentique : l'agent doit avoir tout le contexte. Une application native et un site vitrine sont envisagés plus tard.

## Options étudiées

1. Plusieurs dépôts (front, API, infra)
2. Monorepo avec un orchestrateur (Turborepo, Nx)
3. Monorepo simple : pnpm workspaces + justfile

## Décision

Option 3. Gradle reste dans `apps/api` ; le `package.json` racine et `pnpm-workspace.yaml` ne concernent que les applications JavaScript et les packages partagés ; `just dev`, `just test` et `just lint` unifient les commandes. CI GitHub Actions déclenchée par chemins.

## Conséquences

- ✅ Une évolution de bout en bout tient dans une seule PR
- ✅ Contrat OpenAPI versionné dans `contracts/` : la CI détecte toute dérive entre front et back
- ✅ Un `CLAUDE.md` racine et un par application
- 🔁 Turborepo ajouté à l'arrivée d'une troisième application
