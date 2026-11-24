# Commandes du projet : `just --list` pour les afficher.
# L'identité de marque (BRAND_*, VITE_BRAND_*) vient de brand.env,
# chargé et exporté vers chaque commande.

set dotenv-load
set dotenv-filename := "brand.env"
set shell := ["bash", "-euo", "pipefail", "-c"]

# Affiche la liste des commandes
[private]
default:
    @{{ just_executable() }} --list --justfile {{ justfile() }}

# Lance l'API et le front en mode développement
dev: _brand (_indisponible "dev")

# Lance tous les tests (API et front)
test: _brand (_indisponible "test")

# Lance les tests de l'API (Gradle)
test-api: _brand (_indisponible "test-api")

# Lance les tests du front (Vitest)
test-web: _brand (_indisponible "test-web")

# Vérifie le style et la qualité du code (API et front)
lint: _brand (_indisponible "lint")

# Valide le contrat OpenAPI et régénère le client TypeScript
contract: _brand (_indisponible "contract")

# Arrête la commande si brand.env est absent
[private]
_brand:
    @test -f brand.env || { echo "brand.env introuvable : copier brand.env.example en brand.env (cp brand.env.example brand.env)" >&2; exit 1; }

# Signale une commande dont le squelette n'existe pas encore
[private]
_indisponible name:
    @echo "just {{ name }} : pas encore disponible (squelette à venir)" >&2
    @exit 1
