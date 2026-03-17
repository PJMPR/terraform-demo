# Konfiguracja providera GitHub.
# Provider łączy się z GitHub API przy użyciu tokenu PAT.
#
# ZALECANE: Zamiast podawać token bezpośrednio w zmiennej, ustaw zmienną środowiskową:
#   export GITHUB_TOKEN="ghp_twój_token"       (Linux/macOS)
#   $env:GITHUB_TOKEN="ghp_twój_token"         (Windows PowerShell)
#
# Jeśli zmienna środowiskowa GITHUB_TOKEN jest ustawiona, blok poniżej
# NIE wymaga jawnego podania `token` – provider wykryje go automatycznie.

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

