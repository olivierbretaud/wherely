---
status: accepté
date: 2026-11-20
domaine: Backend
sections-cdc: "7.1, 7.6"
source: https://app.notion.com/p/41eb1edbc9ba812d92dbceb22f08b1e9
---

# ADR-3 : Gradle (Kotlin DSL) comme outil de build

**Décision** : Gradle avec Kotlin DSL et wrapper inclus dans apps/api

## Contexte

Le backend a besoin d'un outil de build pour les dépendances, la compilation, les tests, la couverture (JaCoCo) et l'image Docker, utilisable à l'identique en local et en CI.

## Options étudiées

1. Maven : déclaratif (XML), très répandu, conventions strictes
2. Gradle avec Kotlin DSL : scripts typés, builds incrémentaux et cache, plus flexible

## Décision

Gradle avec Kotlin DSL (`build.gradle.kts`) et wrapper versionné dans `apps/api`. Maven a été envisagé un temps, puis écarté au profit de Gradle pour rester cohérent avec la base technique retenue (Gradle, Liquibase, JJWT, Lombok, découpage core / engine).

## Conséquences

- ✅ Builds plus rapides grâce au cache et à l'incrémental, autocomplétion dans l'IDE
- ✅ Le wrapper garantit la même version partout, y compris pour les agents
- ⚠️ Scripts plus libres que Maven : conventions à documenter dans `apps/api/CLAUDE.md`
