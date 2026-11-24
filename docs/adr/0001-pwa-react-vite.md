---
status: accepté
date: 2026-11-20
domaine: Front
sections-cdc: "1.4, 6.1, 7.1, 7.5"
source: https://app.notion.com/p/41eb1edbc9ba81b49001ff53989a48ba
---

# ADR-1 : Application web progressive (PWA) en React + Vite

**Décision** : SPA React 19 + TypeScript + Vite, installable en PWA (vite-plugin-pwa), sans application native ni rendu serveur en V1

## Contexte

Wherely doit fonctionner sur mobile, tablette et ordinateur, être installé sur l'écran d'accueil et partager un voyage par simple lien. Le projet est mené par un seul développeur.

## Options étudiées

1. Applications natives iOS et Android (ou Expo / React Native) publiées sur les stores
2. Application Next.js avec rendu serveur
3. SPA React + Vite installable en PWA

## Décision

Option 3 : SPA React 19 + TypeScript construite avec Vite, servie en statique par Caddy, rendue installable avec vite-plugin-pwa (manifest, service worker, page hors ligne).

## Justification

- Un seul code pour tous les appareils, pas de validation ni de commission des stores
- Le référencement n'est pas un objectif : le rendu serveur n'apporte rien, d'autant que Wherely n'a aucune page publique (ADR-22)
- Build statique simple à héberger, aucun serveur Node à exploiter

## Conséquences

- ✅ Déploiement continu, coût réduit, invitation par simple lien
- ⚠️ Limites de Safari iOS (installation manuelle, iOS 16.4 minimum) : guide d'installation nécessaire
- ⚠️ Pas d'accès direct à la photothèque : sélection des photos par l'utilisateur
- 🔁 Une application native reste possible plus tard dans `apps/mobile`, en réutilisant le client API et la logique métier
