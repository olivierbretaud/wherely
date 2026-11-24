---
status: accepté
date: 2026-11-20
domaine: Front
sections-cdc: "7.1, 7.2"
source: https://app.notion.com/p/41eb1edbc9ba81cc9a19ffeffd700f72
---

# ADR-9 : Carte MapLibre GL avec l'imagerie satellite Esri

**Décision** : MapLibre GL JS + tuiles raster Esri World Imagery en V1 ; fond Plan et bascule Plan / Satellite en V2

## Contexte

La carte est la colonne vertébrale du récit de voyage. La vue satellite met en valeur les paysages (randonnée, montagne, littoral).

## Options étudiées

1. Fond vectoriel « Plan » (OpenFreeMap, MapTiler) seul
2. Imagerie satellite Esri World Imagery
3. Les deux avec bascule

## Décision

MapLibre GL JS avec les tuiles raster Esri World Imagery en V1, attribution « © Esri » affichée, usage encadré par un compte ArcGIS et une clé d'API avant la beta publique. La V2 ajoute un fond « Plan » et un bouton de bascule Plan / Satellite.

## Conséquences

- ✅ Rendu visuel fort dès la V1, sans coût au démarrage
- ⚠️ Conditions d'utilisation et quotas Esri à valider ; source de tuiles configurable pour basculer vers un fond européen
- ⚠️ L'adresse IP du visiteur est transmise à Esri (États-Unis, certifié DPF) : mention dans la politique de confidentialité
