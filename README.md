# Carnet de voyage (nom provisoire)

> Le nom définitif du produit n'est pas encore arrêté (voir ADR-25).

Application de carnet de voyage : à partir des photos d'un voyage, l'application lit les données EXIF (position GPS, date de prise de vue), reconstitue l'itinéraire sur une carte et une timeline jour par jour, et permet de partager le voyage avec ses compagnons.

## Organisation du dépôt

Monorepo : front, backend, contrat d'API, infrastructure et documentation dans un seul dépôt.

```txt
apps/
  api/            backend Java / Spring Boot (Gradle)
  web/            front React + Vite (PWA)
packages/
  api-client/     types et client TypeScript générés depuis l'OpenAPI
  core/           logique métier partagée (clustering, EXIF, formatage)
  config/         configurations partagées (TypeScript, Biome)
contracts/        spécification OpenAPI exportée par l'API
infra/            Docker Compose, Caddy, Ansible, scripts d'exploitation
docs/             cahier des charges, spécifications, ADR
.github/workflows CI déclenchée par chemins
```

## Prérequis

| Outil | Version |
| --- | --- |
| Java | 25 (LTS) |
| Node.js | 24 ou plus |
| pnpm | 10 |
| Docker + Docker Compose | récent |
| just | récent |

## Démarrage

```sh
pnpm install          # installe les dépendances de toutes les applications JS
cp .env.example .env  # puis renseigner les valeurs locales
```

Les commandes unifiées (`just dev`, `just test`, `just lint`) arriveront avec le `justfile`.

## Configuration locale

Les fichiers propres à chaque poste ne sont jamais versionnés : `.env`, `.env.*` (sauf `.env.example`) et `.claude/settings.local.json`.
