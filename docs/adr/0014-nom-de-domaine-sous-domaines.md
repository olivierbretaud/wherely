---
status: accepté
date: 2026-11-20
domaine: Infra
sections-cdc: "7.3"
source: https://app.notion.com/p/41eb1edbc9ba8193a8bac297776c6206
---

# ADR-14 : Nom de domaine wherely.app chez OVHcloud et sous-domaines

**Décision** : wherely.app chez OVHcloud ; app., api., status. et mail. ; racine réservée au futur site vitrine

## Contexte

L'application a besoin d'un domaine pour le HTTPS, les e-mails et les liens partagés. Un site vitrine et une application native pourraient arriver plus tard.

## Options étudiées

1. `.fr` : le moins cher, mais ancré en France
2. `.com` : universel, souvent déjà pris
3. `.app` : adapté à une application, HTTPS imposé
4. Registraire OVHcloud ou Cloudflare Registrar (prix coûtant)

## Décision

`wherely.app` (repli `wherely.com`), enregistré chez OVHcloud comme le VPS. Sous-domaines : `app.` (PWA, sans page publique), `api.` (Spring Boot), `status.` (Uptime Kuma), `mail.` (envoi des e-mails). La racine redirige vers `app.` en attendant le site vitrine.

## Conséquences

- ✅ Un seul fournisseur et une seule facture, données dans l'UE, environ 22 € TTC par an
- ✅ `app.` et `api.` restent sur le même site : cookie `SameSite=Strict` conservé ; CORS limité à `https://app.wherely.app`
- ⚠️ DNSSEC, CAA (Let's Encrypt), verrouillage et renouvellement automatique à activer
