# ──────────────────────────────────────────────────────────────────────────────
# Data Sources – odczytywanie istniejących zasobów z GitHub API
# ──────────────────────────────────────────────────────────────────────────────
#
# `data` w Terraform służy do ODCZYTU zasobów, które już istnieją –
# nie tworzy ani nie zmienia żadnych zasobów na GitHubie.
#
# Kiedy używać data sources?
#   - Chcesz odczytać dane istniejącego repozytorium/użytkownika
#   - Chcesz użyć ID istniejącego zasobu w nowym zasobie (np. branch protection)
#   - Chcesz sprawdzić obecny stan zasobu bez zarządzania nim przez Terraform
#
# Składnia:
#   data "<provider_typ>" "<lokalna_nazwa>" { ... }
#   Odwołanie: data.<typ>.<lokalna_nazwa>.<atrybut>
# ──────────────────────────────────────────────────────────────────────────────


# ── 1. Dane zalogowanego użytkownika (właściciela tokenu PAT) ─────────────────
#
# Odczytuje informacje o koncie GitHub powiązanym z aktywnym tokenem PAT.
# Przydatne do dynamicznego pobierania nazwy użytkownika zamiast hardkodowania.

data "github_user" "current" {
  # Pusty string oznacza "zalogowany użytkownik" (właściciel tokenu)
  username = ""
}


# ── 2. Dane istniejącego repozytorium ─────────────────────────────────────────
#
# Odczytuje metadane repozytorium, które zostało właśnie utworzone przez moduł.
# Uwaga: data source odczytuje stan z GitHub API – repozytorium musi już istnieć.
# Dlatego używamy `depends_on`, aby Terraform najpierw je stworzył.

data "github_repository" "demo" {
  # Pełna nazwa repozytorium w formacie "owner/repo"
  full_name = "${var.github_owner}/${local.repository_full_name}"

  # depends_on wymusza kolejność: najpierw stwórz repo (module), potem odczytaj (data)
  depends_on = [module.demo_repository]
}


# ── 3. Dane gałęzi repozytorium ───────────────────────────────────────────────
#
# Odczytuje informacje o konkretnej gałęzi – np. SHA ostatniego commita.
# Przydatne przy konfigurowaniu branch protection lub CI/CD.

data "github_branch" "main" {
  repository = local.repository_full_name
  branch     = "main"

  # Gałąź "main" istnieje dopiero po inicjalizacji repo (auto_init = true)
  depends_on = [module.demo_repository]
}


# ── 4. Dane użytkownika po nazwie ─────────────────────────────────────────────
#
# Odczytuje publiczny profil dowolnego użytkownika GitHub po jego loginie.
# Można użyć do sprawdzenia ID użytkownika przy dodawaniu collaboratorów.

data "github_user" "owner" {
  username = var.github_owner
}


# ── 5. Dane team (opcjonalne – tylko dla organizacji) ─────────────────────────
#
# UWAGA: Ten data source działa tylko na kontach organizacyjnych (GitHub Org),
#        NIE na kontach osobistych. Odkomentuj jeśli używasz GitHub Organization.
#
# data "github_team" "example" {
#   slug = "nazwa-zespolu"    # np. "backend-team"
# }

