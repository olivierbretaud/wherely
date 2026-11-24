---
status: accepté
date: 2026-11-20
domaine: RGPD
sections-cdc: "5.1, 6.10, 7.4"
source: https://app.notion.com/p/41eb1edbc9ba81afb277de209e46ff3e
---

# ADR-18 : Espace d'administration minimal et tracé dès la V1

**Décision** : Administration en Must : accès limité au strict nécessaire, aucun accès aux voyages privés hors signalement, TOTP, journal d'audit en ajout seul

## Contexte

Dès la V1, il faut traiter les signalements (DSA), les demandes RGPD, les comptes de mineurs et les suspicions de piratage. L'administrateur pourrait techniquement tout voir, alors que les voyages contiennent des photos privées et des positions GPS.

## Options étudiées

1. Pas d'interface : interventions directes en base via tunnel SSH
2. Administration complète avec accès à tous les contenus et connexion « en tant que » un utilisateur
3. Administration minimale, limitée aux actions nécessaires et tracée

## Décision

Option 3, en Must pour la V1 :

- Liste des comptes sans GPS, photos ni titres ; recherche par e-mail exact
- Contenu visible uniquement s'il a été signalé ; pas de connexion « en tant que », pas d'export en masse
- Fonctions : comptes, signalements, demandes RGPD (table `privacy_requests`), journal de connexion d'un compte, quotas
- Journal `admin_audit_log` en ajout seul, motif obligatoire, conservé 12 mois
- TOTP obligatoire, session de 15 minutes d'inactivité, mot de passe redemandé avant une action irréversible

## Conséquences

- ✅ Conforme aux principes de minimisation et de responsabilité du RGPD ; preuve des actions en cas de contrôle ou de contestation
- ✅ Les interventions directes en base deviennent exceptionnelles
- ⚠️ Environ 3 points de charge supplémentaires (journal d'audit, demandes RGPD)
- ⚠️ Certaines investigations restent impossibles depuis l'interface : un accès exceptionnel en base doit lui aussi être consigné dans le journal
