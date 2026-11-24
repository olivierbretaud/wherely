---
status: accepté
date: 2026-11-20
domaine: Backend
sections-cdc: "7.4, 9.2"
source: https://app.notion.com/p/41eb1edbc9ba81699174e0a25fb90925
---

# ADR-8 : Médias sur Cloudinary derrière une interface de stockage interchangeable

**Décision** : Cloudinary en V1 via l'interface MediaStorage ; base indépendante du fournisseur ; migration vers un stockage S3 européen prévue et scriptée

## Contexte

Toutes les photos et vidéos sont hébergées côté serveur. Il faut un CDN, des miniatures à plusieurs tailles et la conversion HEIC, sans stocker les fichiers sur le disque du VPS (75 Go).

## Options étudiées

1. Disque du VPS : gratuit mais limité, sans CDN
2. Stockage S3 européen (Scaleway, OVHcloud, R2) : peu cher, mais miniatures à générer soi-même
3. Cloudinary : CDN, transformations à la volée (`q_auto`, `f_auto`), vidéo

## Décision

Cloudinary en V1, toujours appelé à travers l'interface `MediaStorage` (`CloudinaryMediaStorage`). La base stocke le fournisseur et une clé (`wherely/{env}/{travelId}/{uuid}.{ext}`), jamais l'URL ; le front demande des variantes nommées (`thumbnail`, `card`, `full`).

## Conséquences

- ✅ Aucun travail d'optimisation d'image en V1
- ⚠️ Coût : plan gratuit jusqu'à environ 100 utilisateurs actifs, plan Plus jusqu'à environ 900 ; migration S3 déclenchée à 80 % des crédits du plan Plus
- ⚠️ Fournisseur américain : voir ADR-15 (EXIF retirés, DPF)
- ⚠️ Copie unique des photos en V1 : risque accepté, script de migration utilisable comme export
