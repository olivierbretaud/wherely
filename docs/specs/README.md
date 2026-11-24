# Spécifications fonctionnelles

Spécifications des fonctionnalités complexes, écrites juste avant leur développement. Le cahier des charges (`docs/spec.md`) dit **quoi et pourquoi**, la spec dit **quelles règles exactement**, la tâche du backlog dit **quel morceau livrer**. Un agent lit la spec concernée avant de coder.

La source de rédaction est la page Notion « Spécifications » ; chaque spec y est rédigée puis recopiée ici, sans réécriture.

## Quand écrire une spec

- Une fonctionnalité avec plusieurs règles de gestion, des cas limites ou des droits par rôle : spec obligatoire avant le développement
- Un CRUD simple ou une tâche technique : les critères d'acceptation de la tâche suffisent
- Pas de développement d'une fonctionnalité complexe sans spec au statut « Validée »

## Nommage des fichiers

```txt
SPEC-<numéro>-<nom>.md
```

- `<numéro>` : numéro de la spec dans Notion, sans zéros devant (`SPEC-1`, `SPEC-12`)
- `<nom>` : titre court en minuscules, sans accents, mots séparés par des tirets
- Exemple : `SPEC-1-inscription-verification-email.md`

L'en-tête YAML de chaque fichier reprend le numéro, le statut, la version, le domaine, le préfixe des règles, les sections du cahier des charges et le lien vers la page Notion.

## Règles de gestion numérotées

- Chaque règle porte un identifiant `RG-<DOMAINE>-<nn>` : `RG-REG-01`, `RG-INV-01`, `RG-AUTH-03`…
- Le préfixe de domaine est propre à une spec (`RG-REG` pour SPEC-1)
- Un numéro n'est jamais réutilisé, même si la règle est supprimée
- Chaque test et chaque PR citent les règles qu'ils couvrent
- Scénarios d'acceptation au format Given / When / Then (Gherkin) : le sous-agent `test-writer` les transforme en tests avant l'implémentation
- Messages d'erreur rédigés en français et en anglais, avec leur clé de traduction

## Cycle de vie

| Statut | Signification |
| --- | --- |
| À rédiger | Identifiée, pas encore écrite |
| Brouillon | En cours d'écriture (à la main ou par le skill `/spec`) |
| En revue | Relue, questions ouvertes listées |
| Validée | Prête pour le développement ; toute modification ultérieure incrémente sa version |
| Obsolète | Remplacée par une autre spec ou par une évolution du produit |

## Index

| Spec | Titre | Domaine | Statut | Version |
| --- | --- | --- | --- | --- |
