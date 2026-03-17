# Główny plik konfiguracji – punkt wejścia projektu Terraform.
# Tutaj wywołujemy moduły i definiujemy główne zasoby.

# ──────────────────────────────────────────────
# Moduł: Repozytorium GitHub (demo główne)
# ──────────────────────────────────────────────
# Ten moduł tworzy realne repozytorium GitHub.
# Możesz go uruchomić od razu po konfiguracji tokenu i właściciela.

module "demo_repository" {
  source = "./modules/repository"

  # Przekazujemy lokalnie wyliczoną nazwę z prefiksem "training-"
  name        = local.repository_full_name
  description = var.repository_description
  visibility  = var.repository_visibility

  has_issues   = var.repository_has_issues
  has_wiki     = var.repository_has_wiki
  auto_init    = var.repository_auto_init
  topics       = local.common_topics
}

# ──────────────────────────────────────────────
# Moduł: Branch Protection (ćwiczenie)
# ──────────────────────────────────────────────
# ĆWICZENIE: Odkomentuj i uzupełnij ten moduł po zaimplementowaniu
# modułu modules/branch_protection.
#
# module "demo_branch_protection" {
#   source = "./modules/branch_protection"
#
#   repository = module.demo_repository.name
#   branch     = "main"
# }

# ──────────────────────────────────────────────
# Moduł: Labels (ćwiczenie)
# ──────────────────────────────────────────────
# ĆWICZENIE: Odkomentuj i uzupełnij ten moduł po zaimplementowaniu
# modułu modules/labels.
#
# module "demo_labels" {
#   source = "./modules/labels"
#
#   repository = module.demo_repository.name
#   labels     = [
#     { name = "bug",         color = "d73a4a", description = "Something isn't working" },
#     { name = "enhancement", color = "a2eeef", description = "New feature or request" },
#     { name = "training",    color = "0075ca", description = "Created during training" },
#   ]
# }

