---
status: accepté
date: 2026-11-20
domaine: Organisation
sections-cdc: "7.7"
source: https://app.notion.com/p/41eb1edbc9ba814ba100f70caf297261
---

# ADR-13 : Stratégie Git : branches staging et main

**Décision** : Branches de tâche fusionnées en squash dans staging ; PR de release staging → main en merge commit, qui déclenche le déploiement ; Conventional Commits et release-please

## Contexte

Un développeur unique, assisté d'agents qui ouvrent des PR, doit pouvoir regrouper plusieurs tâches avant de les mettre en production, sans maintenir un environnement de staging.

## Options étudiées

1. Trunk-based : chaque PR fusionnée dans `main` part en production
2. Git Flow complet (develop, release, hotfix)
3. Deux branches durables : `staging` (intégration) et `main` (production)

## Décision

Option 3. `staging` est une branche, pas un environnement : elle reçoit les PR de tâche en squash merge et lance la CI complète sans déployer. `main` ne reçoit que des PR depuis `staging` (ou `hotfix/*`), fusionnées en merge commit ; chaque fusion déploie en production, puis release-please crée le tag SemVer et le changelog.

## Conséquences

- ✅ Production stable, releases groupées et traçables
- ✅ Historique commun entre staging et main grâce au merge commit
- ⚠️ Pas d'environnement de pré-production : les tests de bout en bout tournent sur la PR de release
- 🤖 Les fusions restent humaines ; push sur main ou staging et force push interdits à l'agent
