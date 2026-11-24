---
status: accepté
date: 2026-11-20
domaine: RGPD
sections-cdc: "6.10, 5.1"
source: https://app.notion.com/p/41eb1edbc9ba8196af32faf0b0af8333
---

# ADR-17 : Âge minimum de 16 ans avec vérification déclarative

**Décision** : Inscription réservée aux 16 ans et plus, case déclarative obligatoire, sans date de naissance ni vérification d'identité

## Contexte

Wherely héberge des photos et des positions, permet le partage public et l'invitation d'amis. En France, un mineur peut consentir seul au traitement de ses données à partir de 15 ans (16 ans par défaut dans le RGPD) ; une loi de juillet 2026 interdit les réseaux sociaux aux moins de 15 ans, avec un périmètre encore flou.

## Options étudiées

1. 15 ans : aligné sur le seuil français
2. 16 ans : seuil le plus haut autorisé par le RGPD, valable dans toute l'UE
3. 18 ans : aucune règle propre aux mineurs

## Décision

16 ans, vérifiés par une case obligatoire non précochée « J'ai 16 ans ou plus », y compris pour un invité ou une inscription OAuth. Seule la date de confirmation est enregistrée. Un compte signalé comme appartenant à un mineur de moins de 16 ans est désactivé puis supprimé.

## Conséquences

- ✅ Une seule règle pour toute l'UE, marge par rapport à la loi française
- ✅ Minimisation des données : pas de date de naissance ni de pièce d'identité
- ⚠️ Les 15 ans sont exclus
- 🔁 À réétudier si Wherely est qualifié de réseau social par les textes d'application
