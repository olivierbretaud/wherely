---
status: accepté
date: 2026-11-20
domaine: Backend
sections-cdc: "7.1, 7.4"
source: https://app.notion.com/p/41eb1edbc9ba81878416d8aaeaaf2268
---

# ADR-20 : Architecture du backend : monolithe en couches core / engine

**Décision** : Conserver le monolithe en couches (Controller → Service → Repository) découpé en core / engine pour la V1 ; monolithe modulaire et hexagonal écartés, à réévaluer après le lancement

## Contexte

Le backend Spring Boot est organisé en deux parties : `core` (un package par module métier : controller, service + interface, DTO, mapper) et `engine` (entités JPA, repositories, configuration, exceptions, pagination partagés). C'est un **monolithe en couches** (Controller → Service → Repository), organisé par fonctionnalité pour le métier et par couche technique pour la persistance.

La question s'est posée de passer à une architecture plus structurante, alors que le projet est mené par un développeur unique qui apprend Java et Spring Boot, avec une marge de planning d'environ 20 % avant le lancement de juin 2027.

## Options étudiées

### 1. Monolithe en couches core / engine (actuel)

- ✅ Modèle Spring Boot classique, simple, bien documenté, facile à suivre pour un agent
- ⚠️ Entités et repositories partagés : un module peut lire les tables d'un autre ; frontières non vérifiées

### 2. Monolithe modulaire avec hexagonal léger

- Un package par module possédant ses entités et ses repositories, API publique à la racine du module, communication par API ou par événements (`MediaUploaded`, `UserDeleted`), vérifiée par Spring Modulith et ArchUnit
- Ports pour tous les services externes (stockage, géocodage, e-mail, mots de passe compromis, horloge), règles critiques en Java pur
- ✅ Frontières claires, évolutivité, valeur d'apprentissage et pour le CV
- ⚠️ Environ 2 points de mise en place, et de nouvelles notions à apprendre en même temps que Spring Boot

### 3. Architecture hexagonale ou Clean Architecture complète

- Domaine en Java pur séparé des entités JPA, ports entrants (cas d'usage) et sortants, adaptateurs web et persistance, règles de dépendance vérifiées
- ✅ Testabilité maximale, fournisseurs remplaçables partout
- ⚠️ Trois représentations par objet (DTO, domaine, entité JPA), 30 à 50 % de fichiers en plus, environ 10 à 15 jours supplémentaires sur le backend

## Décision

Option 1 : le monolithe en couches `core` / `engine` est conservé pour la V1, tel que décrit dans le cahier des charges (7.4). Les deux interfaces déjà prévues, `MediaStorage` et `ReverseGeocoder`, isolent les fournisseurs les plus susceptibles de changer (Cloudinary, Photon).

## Conséquences

- ✅ Aucune charge supplémentaire, apprentissage concentré sur Spring Boot
- ⚠️ Les frontières entre modules reposent sur la discipline et la revue de code (agent `reviewer` et relecture humaine), pas sur un contrôle automatique
- 💡 Recommandé sans changer d'architecture : regrouper les règles de droits sur un voyage dans une seule classe (par exemple `TravelPermissionPolicy` dans `core/members`), testée avec la matrice des droits
- 🔁 À réévaluer après le lancement de la v1.0, ou si une application native ou de nouveaux domaines arrivent : migration possible module par module vers l'option 2, sans réécriture complète
