---
status: accepté
date: 2026-11-20
domaine: Données
sections-cdc: "7.4"
source: https://app.notion.com/p/41eb1edbc9ba81a0a2c9f080e98aa27d
---

# ADR-23 : Tables de référence pour toutes les listes de valeurs

**Décision** : Chaque liste récurrente est une table ref_* (code en clé primaire) liée par clé étrangère, reflétée par un enum Java ; libellés traduits par le front

## Contexte

Le modèle contient de nombreuses listes de valeurs (rôles, statuts, types de médias, motifs de signalement, actions d'administration…) stockées jusqu'ici en texte libre : rien n'empêchait en base une valeur invalide, et les valeurs possibles n'étaient documentées que dans des commentaires.

## Options étudiées

1. Texte + contrainte `CHECK` : simple, mais valeurs cachées dans une contrainte, sans attributs
2. Type `ENUM` PostgreSQL : typé, mais retrait de valeur difficile et mal supporté par certains outils
3. Table de référence par liste, liée par clé étrangère

## Décision

Option 3, pour toutes les listes :

- Tables préfixées `ref_` (16 au départ, liste en 7.4 du cahier des charges) avec `code` (clé primaire), `sort_order`, `is_active`, `description`
- La colonne utilisatrice stocke directement le code (`users.role = 'admin'`) avec une clé étrangère vers la table de référence
- Enum Java en miroir, mappé en `EnumType.STRING`, et test d'intégration de cohérence entre enum et table
- Libellés traduits par le front (`fr.json`, `en.json`), jamais stockés en base
- Valeurs chargées et modifiées uniquement par des changesets Liquibase ; retrait par `is_active = false`

## Conséquences

- ✅ Intégrité garantie par la base, valeurs listées et documentées (diagramme et tbls)
- ✅ Données lisibles sans jointure grâce au code en clé primaire
- ✅ Les référentiels plus riches (tags et activités, motifs de signalement) pourront porter des attributs supplémentaires
- ⚠️ Seize tables et changesets à maintenir ; ajout d'une valeur = changeset + mise à jour de l'enum + traduction
- ⚠️ Une valeur présente dans l'enum mais absente de la table (ou l'inverse) fait échouer le test de cohérence : c'est voulu
