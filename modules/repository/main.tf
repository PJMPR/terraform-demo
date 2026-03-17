# Główna logika modułu repository.
# Tworzy repozytorium GitHub przy użyciu providera integrations/github.

# Dokumentacja zasobu:
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository

resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  # Funkcjonalności repozytorium
  has_issues   = var.has_issues
  has_wiki     = var.has_wiki
  has_projects = var.has_projects

  # Inicjalizacja – tworzy pusty commit z plikiem README.md
  # Wymagane, jeśli chcesz od razu dodawać branch protection rules.
  auto_init = var.auto_init

  # Szablony (opcjonalne) – GitHub automatycznie dodaje pliki przy tworzeniu repo
  gitignore_template = var.gitignore_template != "" ? var.gitignore_template : null
  license_template   = var.license_template != "" ? var.license_template : null

  # Topics – odpowiednik tagów dla repozytoriów GitHub
  topics = var.topics

  # Strategia mergowania pull requestów
  allow_merge_commit     = var.allow_merge_commit
  allow_squash_merge     = var.allow_squash_merge
  allow_rebase_merge     = var.allow_rebase_merge
  delete_branch_on_merge = var.delete_branch_on_merge
}

