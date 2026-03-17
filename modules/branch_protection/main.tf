# Moduł: branch_protection
# ─────────────────────────────────────────────────────────────────────────────
# ĆWICZENIE: Zaimplementuj zasób github_branch_protection_v3 lub
#            github_repository_ruleset (nowszy) dla chronionej gałęzi.
#
# Dokumentacja zasobu:
#   https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection
#
# Kroki do wykonania:
#   1. Utwórz zasób `github_branch_protection` używając zmiennych z variables.tf
#   2. Skonfiguruj sekcję `required_pull_request_reviews`
#   3. Skonfiguruj sekcję `required_status_checks` (opcjonalnie)
#   4. Uzupełnij outputs.tf o wartości wyjściowe
#   5. Wywołaj ten moduł z main.tf w katalogu głównym projektu
# ─────────────────────────────────────────────────────────────────────────────

# TODO: Zaimplementuj zasób tutaj.
#
# Przykładowa struktura (do uzupełnienia):
#
# resource "github_branch_protection" "this" {
#   repository_id = ???
#   pattern       = var.pattern
#
#   enforce_admins = var.enforce_admins
#
#   required_pull_request_reviews {
#     required_approving_review_count = var.required_approving_review_count
#     dismiss_stale_reviews           = var.dismiss_stale_reviews
#   }
#
#   required_status_checks {
#     strict   = true
#     contexts = var.required_status_checks
#   }
#
#   allows_force_pushes = var.allow_force_pushes
#   allows_deletions    = var.allow_deletions
# }

