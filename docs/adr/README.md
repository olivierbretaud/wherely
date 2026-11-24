# Décisions d'architecture (ADR)

Chaque décision d'architecture importante est consignée dans un ADR. Le registre de référence est la base Notion « ADR Wherely » (page « Décisions d'architecture ») ; chaque ADR y est rédigé puis recopié ici, sans réécriture.

## Format

- Un fichier par décision : `NNNN-titre.md`, numéro sur quatre chiffres identique au numéro Notion (`ADR-5` → `0005-…`), numérotation continue sans trou
- Format inspiré de [MADR](https://adr.github.io/madr/) : en-tête YAML (`status`, `date`, `domaine`, `sections-cdc`, `source`), puis Contexte, Options étudiées, Décision, Justification (facultative) et Conséquences
- Statuts : `proposé`, `accepté`, `remplacé`, `abandonné`
- Un ADR accepté ne se réécrit pas : une décision qui change fait l'objet d'un nouvel ADR, et l'ancien passe à `remplacé`
- Légende des conséquences : ✅ positif, ⚠️ point de vigilance, 🔁 évolution possible, 🤖 développement agentique, 💡 recommandation

## Index

| ADR | Titre | Domaine | Statut |
| --- | --- | --- | --- |
| [ADR-1](0001-pwa-react-vite.md) | Application web progressive (PWA) en React + Vite | Front | Accepté |
| [ADR-2](0002-backend-java-spring-boot.md) | Backend en Java 25 et Spring Boot 4 | Backend | Accepté |
| [ADR-3](0003-gradle-kotlin-dsl.md) | Gradle (Kotlin DSL) comme outil de build | Backend | Accepté |
| [ADR-4](0004-migrations-liquibase.md) | Migrations de schéma avec Liquibase | Données | Accepté |
| [ADR-5](0005-monorepo-pnpm-justfile.md) | Monorepo avec pnpm workspaces et justfile | Organisation | Accepté |
| [ADR-6](0006-hebergement-vps-ovhcloud.md) | Hébergement sur un VPS OVHcloud VPS-2 avec Docker Compose et Caddy | Infra | Accepté |
| [ADR-7](0007-postgresql-auto-heberge.md) | PostgreSQL 16 auto-hébergé sur le VPS | Données | Accepté |
| [ADR-8](0008-medias-cloudinary.md) | Médias sur Cloudinary derrière une interface de stockage interchangeable | Backend | Accepté |
| [ADR-9](0009-carte-maplibre-esri.md) | Carte MapLibre GL avec l'imagerie satellite Esri | Front | Accepté |
| [ADR-10](0010-geocodage-photon-geonames.md) | Géocodage inverse avec Photon et secours GeoNames local | Backend | Accepté |
| [ADR-11](0011-emails-transactionnels.md) | E-mails transactionnels : Mailpit, Gmail en beta privée, puis Scaleway TEM | Infra | Accepté |
| [ADR-12](0012-authentification-jwt-refresh-argon2id.md) | Authentification : JWT court, refresh token avec rotation et Argon2id | Sécurité | Accepté |
| [ADR-13](0013-strategie-git-staging-main.md) | Stratégie Git : branches staging et main | Organisation | Accepté |
| [ADR-14](0014-nom-de-domaine-sous-domaines.md) | Nom de domaine wherely.app chez OVHcloud et sous-domaines | Infra | Accepté |
| [ADR-15](0015-retrait-exif-transferts-hors-ue.md) | Retrait des EXIF avant stockage et encadrement des transferts hors UE | RGPD | Accepté |
| [ADR-16](0016-documentation-schema-mermaid-tbls.md) | Documentation du schéma : diagramme Mermaid et tbls | Données | Accepté |
| [ADR-17](0017-age-minimum-16-ans.md) | Âge minimum de 16 ans avec vérification déclarative | RGPD | Accepté |
| [ADR-18](0018-espace-administration-minimal.md) | Espace d'administration minimal et tracé dès la V1 | RGPD | Accepté |
| [ADR-19](0019-supervision-logs-performances.md) | Supervision des logs et des performances en production | Infra | Proposé |
| [ADR-20](0020-architecture-backend-core-engine.md) | Architecture du backend : monolithe en couches core / engine | Backend | Accepté |
| [ADR-21](0021-installation-ansible-deploiement-ci.md) | Installation du serveur avec Ansible et déploiement poussé par la CI | Infra | Accepté |
| [ADR-22](0022-aucun-partage-public.md) | Aucun partage public : voyages réservés aux membres, URL basées sur le nom d'utilisateur | Produit | Accepté |
| [ADR-23](0023-tables-de-reference.md) | Tables de référence pour toutes les listes de valeurs | Données | Accepté |
| [ADR-24](0024-labo-kubernetes-argocd.md) | Labo Kubernetes et ArgoCD (GitOps) en parallèle de la production Docker Compose | Infra | Proposé |
| [ADR-25](0025-nom-du-produit.md) | Nom du produit : Wherely, Wheretale ou Wherizon | Produit | Proposé |
