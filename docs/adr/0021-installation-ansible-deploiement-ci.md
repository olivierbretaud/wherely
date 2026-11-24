---
status: accepté
date: 2026-11-20
domaine: Infra
sections-cdc: "7.3, 7.6"
source: https://app.notion.com/p/41eb1edbc9ba81178e7ff58d0ffc1159
---

# ADR-21 : Installation du serveur avec Ansible et déploiement poussé par la CI

**Décision** : VPS installé par un playbook Ansible ; déploiement poussé par GitHub Actions en SSH avec retour arrière automatique ; coupure courte acceptée en V1

## Contexte

L'application tourne sur un seul VPS OVHcloud avec Docker Compose (ADR-6). Il faut pouvoir installer et reconstruire le serveur de façon fiable, déployer chaque release depuis `main` et revenir en arrière rapidement, avec un développeur unique.

## Options étudiées

**A. Installation du serveur**

1. Commandes tapées à la main : rapide une fois, impossible à reproduire à l'identique
2. Script bash idempotent : simple, mais les cas de relance sont à gérer à la main
3. Playbook Ansible : description de l'état voulu, rejouable sans risque, compétence valorisable

**B. Coupure pendant le déploiement**

1. Coupure courte acceptée (15 à 30 secondes de redémarrage de la JVM)
2. Déploiement sans coupure (blue / green) : deux conteneurs API derrière Caddy, environ 2 points de plus

**C. Déclenchement du déploiement**

1. La CI pousse : GitHub Actions se connecte au VPS en SSH
2. Le serveur tire : un outil sur le VPS surveille le registre d'images

## Décision

- **A3** : playbook Ansible dans `infra/ansible/` (rôles base, users, ssh, firewall, docker, app), lancé depuis le poste du développeur
- **B1** : coupure courte acceptée en V1, mises en production aux heures creuses
- **C1** : GitHub Actions publie les images sur GHCR (étiquettes SHA et version), se connecte en SSH avec une clé dédiée, lance `docker compose up -d`, attend le healthcheck et revient automatiquement à l'étiquette précédente en cas d'échec
- Le front est intégré à l'image Caddy (`wherely-web`) pour déployer et restaurer front et back ensemble

## Conséquences

- ✅ Serveur reconstructible à l'identique, runbook dans `infra/README.md`
- ✅ Retour arrière automatique ou manuel (`just rollback <tag>`) en moins d'une minute
- ⚠️ Les migrations Liquibase doivent rester compatibles avec la version précédente (expand / contract)
- ⚠️ Docker contourne UFW : seul Caddy publie des ports
- ⚠️ Courte indisponibilité de l'API à chaque mise en production
- 🔁 Déploiement blue / green envisageable si le trafic le justifie
