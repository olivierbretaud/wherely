---
status: accepté
date: 2026-11-20
domaine: Infra
sections-cdc: "6.4, 7.2"
source: https://app.notion.com/p/41eb1edbc9ba81d18c36c3e08928fd82
---

# ADR-11 : E-mails transactionnels : Mailpit, Gmail en beta privée, puis Scaleway TEM

**Décision** : Spring Mail (SMTP) + Thymeleaf ; Mailpit en local, Gmail SMTP en beta privée, Scaleway Transactional Email à partir de la beta publique

## Contexte

Wherely envoie des e-mails de vérification, d'invitation, de réinitialisation et de notification de sécurité. Ils doivent arriver en boîte de réception, à très faible coût, de préférence depuis l'UE.

## Options étudiées

1. Fournisseurs transactionnels américains (Amazon SES, Postmark, Resend)
2. Fournisseurs européens (Brevo, Mailjet, Scaleway Transactional Email)
3. Compte Gmail en SMTP

## Décision

Envoi en SMTP via Spring Mail, gabarits Thymeleaf, changement de fournisseur par simple configuration :

- Développement et tests : Mailpit (aucun e-mail réel)
- Beta privée : Gmail SMTP avec un compte dédié et un mot de passe d'application (environ 500 e-mails par jour), testeurs informés
- Beta publique et production : Scaleway TEM (France), expéditeur `noreply@mail.wherely.app` avec SPF, DKIM et DMARC

## Conséquences

- ✅ Démarrage gratuit, puis environ 1 à 2 € par mois
- ⚠️ Gmail limité et transfert vers Google : réservé à la beta privée
- ⚠️ Configuration DNS à faire avant la beta publique ; surveillance des rapports DMARC et des retours
