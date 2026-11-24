---
status: accepté
date: 2026-11-20
domaine: RGPD
sections-cdc: "6.4, 6.10, 7.4"
source: https://app.notion.com/p/41eb1edbc9ba816c8d0cc2abf5fb922f
---

# ADR-15 : Retrait des EXIF avant stockage et encadrement des transferts hors UE

**Décision** : Métadonnées enregistrées en France puis retirées des fichiers avant Cloudinary ; transferts vers les États-Unis fondés sur le DPF et les SCC, avec plan de sortie

## Contexte

Cloudinary, Esri, Google et Apple sont américains. Les transferts reposent sur le Data Privacy Framework (DPF), validé par le Tribunal de l'UE en septembre 2025 mais faisant l'objet d'un appel devant la Cour de justice. Les EXIF contiennent la position exacte et l'appareil de l'utilisateur.

## Options étudiées

1. Conserver les fichiers avec leurs EXIF et s'appuyer uniquement sur le DPF
2. Passer immédiatement à un stockage européen
3. Minimiser les données envoyées hors UE et préparer une sortie

## Décision

Option 3 :

- L'API lit les EXIF, les enregistre dans PostgreSQL (France), applique l'orientation puis retire toutes les métadonnées sans réencodage avant l'envoi à Cloudinary ; les HEIC sont convertis en JPEG dans le navigateur
- Sentry en région UE avec masquage des données personnelles
- Chaque transfert (service, pays, données, base légale) listé dans la politique de confidentialité et le registre des traitements
- Plan de sortie : SCC du DPA Cloudinary, migration S3 européenne (ADR-8), fond de carte européen (ADR-9)

## Conséquences

- ✅ Aucune position GPS hébergée hors de l'UE
- ✅ Une annulation du DPF n'impose pas d'arrêt brutal du service
- ⚠️ Tout nouveau service tiers doit être ajouté au tableau des transferts avant sa mise en production
