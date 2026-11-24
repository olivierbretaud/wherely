---
status: accepté
date: 2026-11-20
domaine: Produit
sections-cdc: "3.2, 5.2, 6.4, 6.8, 6.10, 7.4, 7.5"
source: https://app.notion.com/p/41eb1edbc9ba81ac97fdd96a8460cea4
---

# ADR-22 : Aucun partage public : voyages réservés aux membres, URL basées sur le nom d'utilisateur

**Décision** : Pas de lien public ni de page publique : un voyage n'est visible que par ses membres inscrits ; URL /:username pour le profil et /:username/:slug pour les voyages

## Contexte

Le cahier des charges prévoyait jusqu'à la v1.2 le partage d'un voyage par lien public, lisible sans compte (`/:user/:slug`, aperçus Open Graph, visibilité privé / non répertorié / public, signalement sur les pages publiques). Wherely manipule des photos et des positions GPS, et l'invitation d'amis inscrits couvre déjà le besoin de partage entre proches.

## Options étudiées

1. Partage public par lien (lecture sans compte), en plus des invitations
2. Partage uniquement entre membres invités et inscrits

## Décision

Option 2 pour la V1 (option 1 reportée en V2) :

- Aucun voyage public et aucune page publique ; seules l'authentification et les pages légales sont accessibles sans compte
- Un voyage est visible uniquement par ses membres (propriétaire, contributeurs, lecteurs) ; un non-membre reçoit 404, même avec l'URL exacte
- Le nom d'utilisateur (unique) sert de premier segment des URL : `/:username` pour le profil, `/:username/:slug` pour un voyage (nom d'utilisateur du propriétaire, slug unique par propriétaire)
- Les routes de premier niveau sont protégées par la liste des noms réservés (SPEC-1, RG-REG-23) ; un ancien nom d'utilisateur redirige vers le nouveau pendant 6 mois
- Le profil d'un autre utilisateur ne montre que son nom et les voyages partagés avec le visiteur
- Signalement réservé aux membres d'un voyage, adresse de contact pour les autres cas

## Conséquences

- ✅ Vie privée renforcée : aucune photo ni position accessible sans compte
- ✅ Moins de code : plus d'injection Open Graph côté Spring Boot, plus de gestion de visibilité (colonne `visibility` supprimée)
- ✅ DSA : Wherely reste a priori un hébergeur sans diffusion au public, avec des obligations plus légères (à confirmer à la relecture juridique)
- ⚠️ Croissance moins virale : chaque personne doit créer un compte pour voir un voyage ; KPI de partage redéfini (voyages avec au moins un membre invité)
- ⚠️ Un changement de nom d'utilisateur modifie les URL des voyages : redirection temporaire nécessaire
- 🔁 **Partage public par lien prévu en V2**, décidé par un nouvel ADR qui remplacera celui-ci sur ce point. La V1 le prépare déjà : URL `/:username/:slug` stables, slug unique par propriétaire, noms réservés. Points à traiter à ce moment-là : colonne de visibilité (migration expand / contract), aperçus Open Graph injectés par le backend, indexation (noindex conservé ou non), signalement par les visiteurs, EXIF déjà retirés des fichiers, qualification DSA en plateforme en ligne et mise à jour des CGU et de la politique de confidentialité
