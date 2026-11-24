---
status: proposé
date: 2026-11-20
domaine: Produit
sections-cdc: "Identité (Communication)"
source: https://app.notion.com/p/41eb1edbc9ba8198b1bcfdbfa2ff9126
---

# ADR-25 : Nom du produit : Wherely, Wheretale ou Wherizon

**Décision** : À trancher : garder Wherely ou passer à Wheretale ou Wherizon. Wherely.app et wherely.com sont déjà enregistrés par un tiers.

## Contexte

Le nom **Wherely** pose trois problèmes relevés en novembre 2026 :

- **Sens à l'oral :** en anglais, il se prononce presque comme *wearily* (« avec lassitude »), ce qui contredit l'envie de voyage.
- **Orthographe :** « Wherely » n'est pas un mot, d'où des variantes possibles (Wearly, Whereley).
- **Domaine :** `wherely.app` (GoDaddy, depuis avril 2025) et `wherely.com` sont déjà enregistrés par un tiers. Le domaine prévu dans le cahier des charges ne peut donc pas être acheté.

Contrainte retenue : garder « Where » au début du nom, qui porte le sens du produit (le lieu d'une photo).

## Options

| Option | Sens | `.app` | `.com` | `.fr` | `.eu` | Voisinage | Point de vigilance |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **Wherely** (actuel) | « Où » + suffixe -ly | Pris | Pris | Libre | Libre | Aucune application exacte | Homophonie avec *wearily* ; `.app` et `.com` indisponibles |
| **Wheretale** | « Le récit des lieux » | Libre | Libre | Libre | Libre | wherethis (visites audio), usage différent | Orthographe à confirmer à l'oral |
| **Wherizon** | « Le lieu et l'horizon » | Libre | Libre | Libre | Libre | Wheriz (carte de contacts), Wherify (GPS enfants) | Proximité à vérifier en marque |

Relevé du 20/11/2026 auprès des registres : Google (`.app`), Verisign (`.com`), AFNIC (`.fr`) et EURid (`.eu`). « Libre » veut dire « non enregistré », sans garantie de prix standard à l'achat.

**Marque de l'Union européenne :** le registre EURid indique que Wherely, Wheretale et Wherizon sont « disponibles comme marque européenne » : aucune marque de l'UE n'est enregistrée sous ces noms exacts. Cela ne couvre ni les noms proches, ni l'INPI, ni les classes 9 et 42.

### Détail des trois options

**Wherely (garder le nom actuel)**

- Pour : déjà en place partout, aucune application ne porte exactement ce nom.
- Contre : se prononce presque comme *wearily* ; `.app` et `.com` pris par un tiers, il ne reste que `.fr` et `.eu`.
- À retenir : option la plus risquée, car le domaine principal est perdu.

**Wheretale (« le récit des lieux »)**

- Pour : sens clair et positif, centré sur l'histoire du voyage ; le moins de voisinage (seul wherethis, des visites audio, s'en approche) ; quatre domaines libres.
- Contre : « tale » peut être confondu à l'oral avec « tail » (à tester à voix haute) ; nom un peu plus long.
- À retenir : option la plus sûre.

**Wherizon (« le lieu et l'horizon »)**

- Pour : plus évocateur et plus original, évoque l'ailleurs et le voyage ; quatre domaines libres.
- Contre : proche de Wheriz (carte de contacts) et de Wherify (téléphones GPS pour enfants), d'où un dépôt de marque plus délicat.
- À retenir : option la plus belle, un peu plus risquée sur le plan juridique.

**Orientation :** Wheretale pour avancer sans surprise, Wherizon si le nom compte plus que la prudence. Dans les deux cas, vérifier la marque à l'INPI avant tout achat.

Écartés après vérification : Whereo (proche de WhereOrWhen, une application photos et carte), Wherio, Wherelog et Wherebook (non retenus), Cairn, Wayly, Loci, Pinly, Placely, Tracely, Vistaly (déjà utilisés dans l'univers des cartes ou des voyages).

## Critères de choix

- Aucune connotation négative à l'oral, en français comme en anglais
- Une seule orthographe évidente
- Domaines `.app`, `.com`, `.fr` et `.eu` disponibles
- Aucun conflit de marque en classes 9 et 42 (INPI, EUIPO)
- Voisinage limité dans l'univers des cartes et des journaux de voyage

## Avant de décider

- [ ] Vérifier les marques à l'INPI et, pour les noms proches (Wheriz, Wherify), à l'EUIPO, en classes 9 et 42
- [x] Vérifier les domaines `.fr` et `.eu` (libres pour les trois noms, 20/11/2026)
- [ ] Vérifier le domaine `.io`
- [ ] Tester la prononciation à voix haute avec quelques personnes
- [ ] Une fois le nom choisi : réserver le domaine, puis mettre à jour le cahier des charges, les ADR 14 et 15, la page Identité et les tâches du backlog

## Conséquences

Tant que ce choix est ouvert, ne pas acheter de domaine et ne pas publier de contenu de communication sous un nom définitif.

L'identité de marque (nom, domaines, slogans, adresses) est externalisée dans un fichier `brand.env` versionné et sans secret, distinct du `.env` des secrets. Changer de nom ne demande alors que la modification de ce fichier, hors logo, icônes, dépôt GitHub et packages Java. Voir la tâche « Externaliser l'identité de marque dans brand.env » et la section correspondante de la page Identité.
