---
status: accepté
date: 2026-11-20
domaine: Sécurité
sections-cdc: "6.9"
source: https://app.notion.com/p/41eb1edbc9ba8150b97afdbb65568f38
---

# ADR-12 : Authentification : JWT court, refresh token avec rotation et Argon2id

**Décision** : Jeton d'accès JWT de 15 min en mémoire, refresh token de 30 jours en cookie HttpOnly avec rotation, Argon2id, 12 caractères minimum avec règles de composition

## Contexte

L'application stocke des photos privées géolocalisées : l'authentification doit résister au vol de jetons, à la force brute et aux mots de passe compromis, tout en restant simple pour l'utilisateur.

## Options étudiées

1. Sessions serveur classiques (Spring Session)
2. Fournisseur d'identité externe (Keycloak, service managé)
3. Spring Security + JJWT, géré par l'API

## Décision

- JWT d'accès de 15 minutes, conservé en mémoire côté front, vérification de `iss`, `aud` et `exp`
- Refresh token de 30 jours glissants en cookie `HttpOnly`, `Secure`, `SameSite=Strict`, rotation à chaque usage et révocation de toute la famille en cas de réutilisation ; empreinte SHA-256 en base
- Mots de passe : Argon2id (19 Mio, 2 itérations), 12 caractères minimum avec majuscule, minuscule, chiffre et caractère spécial, refus des mots de passe compromis (Have I Been Pwned)
- Blocage après 5 échecs, limitation de débit Bucket4j, pas d'énumération des comptes, TOTP pour les administrateurs

## Conséquences

- ✅ Vol de jeton d'accès limité à 15 minutes, vol de refresh token détecté
- ⚠️ Écart assumé avec la NIST (15 caractères sans règle de composition), compensé par la vérification des mots de passe compromis
- 🔁 V2 : double authentification pour tous (TOTP puis passkeys), liste des sessions actives
