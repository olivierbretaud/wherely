---
status: accepté
date: 2026-11-20
domaine: Backend
sections-cdc: "7.1, 7.4"
source: https://app.notion.com/p/41eb1edbc9ba81eab017d82cb20041ae
---

# ADR-2 : Backend en Java 25 et Spring Boot 4

**Décision** : API REST en Java 25 (LTS) + Spring Boot 4 (Spring Web MVC, Security, Data JPA), découpage core / engine

## Contexte

Le backend gère l'authentification, l'envoi des médias, le contrôle des droits par rôle, le partage et les e-mails. Le projet sert aussi à monter en compétence et à enrichir le CV du développeur.

## Options étudiées

1. Backend-as-a-Service (PostgreSQL et auth managés) : rapide, mais limites de quotas et forte dépendance au fournisseur
2. Node.js + TypeScript (Fastify ou NestJS) : même langage que le front
3. Java + Spring Boot

## Décision

Option 3 : Java 25 (LTS) et Spring Boot 4, avec Spring Security + JJWT, Spring Data JPA, Bean Validation, Lombok et des mappers dédiés. Code découpé en `core` (modules métier : controller, service, DTO, mapper) et `engine` (entités, repositories, configuration, exceptions, pagination).

## Justification

- Objectif d'apprentissage et valeur sur le marché de l'emploi
- Écosystème mature pour la sécurité, la validation, les tests (Testcontainers) et la documentation OpenAPI
- Aucune limite de quotas imposée par un fournisseur

## Conséquences

- ✅ Contrat OpenAPI généré (springdoc) qui sert de référence au front
- ⚠️ Consommation mémoire de la JVM : `-Xmx` plafonné, VPS de 8 Go
- ⚠️ Courbe d'apprentissage : livraison module par module, marge prévue dans le planning
- 🔁 GraalVM Native Image envisageable plus tard pour réduire la mémoire
