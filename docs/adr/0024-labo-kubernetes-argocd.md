---
status: proposé
date: 2026-11-20
domaine: Infra
sections-cdc: "7.3, 7.6"
source: https://app.notion.com/p/41eb1edbc9ba81528fabf36343570d1b
---

# ADR-24 : Labo Kubernetes et ArgoCD (GitOps) en parallèle de la production Docker Compose

**Décision** : À trancher : ajouter un déploiement Kubernetes + ArgoCD de Wherely sur un cluster local (k3d / kind), sans changer la production Docker Compose

> ⏳ Décision reportée. Objectif : monter en compétence sur Kubernetes, Helm et ArgoCD (GitOps), très demandés dans les offres d'emploi visées, sans alourdir la production avant le lancement. À réétudier après le premier déploiement en production, ou plus tôt si une candidature l'exige.

## Contexte

La production de Wherely tourne sur un VPS unique avec Docker Compose (ADR-6, ADR-21), un choix adapté à un développeur seul et à une seule machine. Les offres d'emploi visées (squads Java / React) demandent cependant Kubernetes, Rancher, ArgoCD et GitLab, absents du projet.

## Options étudiées

### Option A — Rester sur Docker Compose uniquement

- ✅ Aucune charge supplémentaire
- ⚠️ Aucune pratique de Kubernetes ni de GitOps à présenter

### Option B — Labo local Kubernetes + ArgoCD, production inchangée

- Manifestes dans `infra/k8s/` : chart Helm (ou Kustomize) pour l'API, le front (image Caddy), PostgreSQL, Ingress, ConfigMaps et Secrets
- Cluster local léger (k3d ou kind) créé par `just k8s-up`
- ArgoCD installé dans le cluster, qui synchronise automatiquement l'application depuis le dépôt (GitOps) ; Rancher optionnel pour l'interface de gestion
- Mêmes images Docker que la production (GHCR), donc aucun code spécifique
- ✅ Pratique concrète de Kubernetes, Helm et ArgoCD, démontrable en entretien
- ✅ Production stable et simple, aucun risque pour le lancement
- ⚠️ Environ 5 points de charge ; un deuxième jeu de manifestes à tenir à jour

### Option C — Production sur k3s directement sur le VPS

- k3s (Kubernetes léger) remplace Docker Compose sur le VPS-2, ArgoCD déploie la production
- ✅ Kubernetes « en vrai », en production
- ⚠️ Complexité et consommation mémoire accrues sur un seul serveur, Ansible et le runbook à reprendre, risque sur le planning de juin 2027

### Complément possible — GitLab

- Miroir du dépôt sur GitLab avec un `.gitlab-ci.yml` équivalent aux workflows GitHub Actions, pour pratiquer GitLab CI ; priorité faible, les concepts étant proches

## Décision

À prendre. Recommandation au moment de l'étude : option B après le lancement de la v1.0, la production restant sur Docker Compose.

## Conséquences une fois la décision prise

- Passer cet ADR au statut « Accepté », compléter la section 7.3 du cahier des charges et l'arborescence `infra/`, créer les tâches dans le backlog
- Pour l'option C : un nouvel ADR remplacerait l'ADR-21 sur le déploiement
