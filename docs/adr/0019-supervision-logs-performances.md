---
status: proposé
date: 2026-11-20
domaine: Infra
sections-cdc: "6.4, 7.1, 7.3"
source: https://app.notion.com/p/41eb1edbc9ba815a90f4e9ddac777307
---

# ADR-19 : Supervision des logs et des performances en production

**Décision** : À trancher avant le premier déploiement en production (mi-février 2027) : pile Grafana auto-hébergée ou Grafana Cloud Free

> ⏳ Décision reportée. À trancher avant le premier déploiement en production, prévu vers mi-février 2027. En attendant, Sentry (erreurs et traces) et Uptime Kuma (disponibilité) restent la base prévue.

## Contexte

Le cahier des charges couvre les erreurs (Sentry) et la disponibilité (Uptime Kuma), mais pas la centralisation des logs ni les métriques de performance : CPU, mémoire de la JVM, temps de réponse de l'API, pool HikariCP, requêtes PostgreSQL. Contraintes : outils gratuits, données de préférence en France, logs conservés 6 mois (6.4), VPS de 8 Go dont environ 3 Go utilisés par la JVM, PostgreSQL et Caddy.

## Options étudiées

### Option A — Pile auto-hébergée sur le VPS

- Prometheus : métriques Spring Boot (Micrometer, `/actuator/prometheus`), postgres\_exporter, node\_exporter, Caddy
- Loki + Grafana Alloy : logs Docker centralisés, au format JSON, sans adresse IP en clair
- Grafana : tableaux de bord et alertes par e-mail (erreurs 5xx, latence, disque, mémoire), accès protégé (sous-domaine sécurisé ou tunnel SSH)
- ✅ Données en France, aucun nouveau transfert hors UE, rétention de 6 mois possible, compétence valorisable
- ⚠️ Environ 1 Go de RAM et de la maintenance (mises à jour, disque)

### Option B — Grafana Cloud Free

- Même pile, gérée par Grafana : 10 000 séries de métriques actives, 50 Go de logs ingérés par mois, 14 jours de rétention (offre relevée en novembre 2026)
- ✅ Aucune maintenance, aucune RAM consommée sur le VPS
- ⚠️ Rétention limitée à 14 jours ; région de données UE à choisir ; service à ajouter au tableau des transferts (6.10)

### Compléments communs aux deux options

- **Sentry** (déjà prévu, région UE) : erreurs et traces de performance du front et de l'API, Core Web Vitals des vrais utilisateurs
- **Surveillance externe indispensable** : Uptime Kuma tourne sur le VPS et ne peut pas alerter si le serveur tombe ; vérification de `/actuator/health` par un service gratuit extérieur (UptimeRobot, Better Stack ou équivalent)
- **Dozzle** : lecture des logs Docker en direct, en dépannage avant la mise en place de Grafana

## Décision

À prendre. Recommandation au moment de l'étude : option A, complétée par Sentry et une surveillance externe.

## Conséquences une fois la décision prise

- Mettre à jour le cahier des charges (6.4, 7.1, 7.3) et, pour l'option B, le tableau des transferts hors UE (6.10)
- Passer cet ADR au statut « Accepté » et créer les tâches correspondantes dans le backlog
