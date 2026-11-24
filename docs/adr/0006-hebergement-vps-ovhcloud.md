---
status: accepté
date: 2026-11-20
domaine: Infra
sections-cdc: "7.1, 7.3"
source: https://app.notion.com/p/41eb1edbc9ba816c8034d960d4afec7c
---

# ADR-6 : Hébergement sur un VPS OVHcloud VPS-2 avec Docker Compose et Caddy

**Décision** : OVHcloud VPS-2 (4 vCores, 8 Go, 75 Go NVMe) en France, Docker Compose, Caddy en reverse proxy HTTPS

## Contexte

Il faut héberger le front statique, l'API Spring Boot et PostgreSQL à coût fixe et faible, dans l'UE, sans limites de quotas ni démarrage à froid.

## Options étudiées

1. Plateformes serverless ou PaaS : simples mais coût variable, quotas, démarrages à froid, JVM mal adaptée
2. VPS Hetzner : excellent rapport prix / performance
3. VPS Hostinger ou Contabo : moins chers ou plus puissants, mais support et fiabilité moins constants
4. VPS OVHcloud VPS-2

## Décision

OVHcloud VPS-2 sous Ubuntu LTS, environ 8,65 € TTC par mois sans engagement (tarif de novembre 2026), avec Docker Compose (Caddy, API, PostgreSQL, sauvegardes). Caddy gère le HTTPS automatique et le routage des sous-domaines.

## Justification

- Datacenter en France, RGPD simplifié
- 8 Go de RAM : marge suffisante pour la JVM et PostgreSQL
- Sauvegarde quotidienne du VPS et anti-DDoS inclus ; passage au VPS-3 en un clic

## Conséquences

- ✅ Coût fixe et prévisible
- ⚠️ Exploitation à la charge du développeur : sécurisation (SSH par clé, pare-feu, fail2ban), mises à jour, supervision
- ⚠️ Serveur unique : installation et déploiement scriptés pour reconstruire rapidement
