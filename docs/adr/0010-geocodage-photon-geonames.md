---
status: accepté
date: 2026-11-20
domaine: Backend
sections-cdc: "7.2, 7.4"
source: https://app.notion.com/p/41eb1edbc9ba812cacd9fd9a3c4a785c
---

# ADR-10 : Géocodage inverse avec Photon et secours GeoNames local

**Décision** : Photon (API publique) en principal, base GeoNames cities500 en mémoire en secours dès la V1, derrière l'interface ReverseGeocoder

## Contexte

Chaque photo doit recevoir sa ville, sa région et son pays à partir de ses coordonnées GPS. L'API publique Photon est gratuite mais sans garantie de disponibilité.

## Options étudiées

1. Photon seul
2. Photon hébergé sur le VPS : écarté, la base mondiale demande environ 95 Go
3. Fournisseur à clé d'API (Geoapify, LocationIQ) en secours
4. Base locale GeoNames en secours

## Décision

Photon en fournisseur principal ; bascule automatique sur une base GeoNames locale (`cities500`, `admin1CodesASCII`, `countryInfo`) chargée en mémoire dans un index spatial si Photon échoue ou dépasse 2 secondes. Lieu le plus proche dans un rayon de 50 km, sinon région et pays. Source du résultat enregistrée (`photon`, `geonames`, `manual`).

## Conséquences

- ✅ L'envoi d'une photo n'est jamais bloqué, même sans réseau externe
- ⚠️ Résultat GeoNames approximatif près des frontières : marqué comme tel
- ⚠️ Licence CC BY 4.0 : mention GeoNames dans les crédits ; fichiers rafraîchis chaque trimestre dans l'image Docker
- 🔁 Évolution : géocodage en arrière-plan, cache, Geoapify ou LocationIQ
