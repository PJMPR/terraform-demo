# Moduł: labels
# ─────────────────────────────────────────────────────────────────────────────
# ĆWICZENIE: Zaimplementuj zasób github_issue_label dla każdej etykiety
#            przekazanej przez zmienną `labels`.
#
# Dokumentacja zasobu:
#   https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label
#
# Kroki do wykonania:
#   1. Użyj konstrukcji `for_each` do iteracji po zmiennej `labels`
#   2. Utwórz zasób `github_issue_label` dla każdego elementu
#   3. Uzupełnij outputs.tf o mapę stworzonych etykiet
#   4. Wywołaj ten moduł z main.tf w katalogu głównym projektu
#
# Wskazówka: Przekształć listę na mapę za pomocą:
#   for_each = { for label in var.labels : label.name => label }
# ─────────────────────────────────────────────────────────────────────────────

# TODO: Zaimplementuj zasób tutaj.
#
# Przykładowa struktura (do uzupełnienia):
#
# resource "github_issue_label" "this" {
#   for_each = ???
#
#   repository  = var.repository
#   name        = each.value.name
#   color       = each.value.color
#   description = each.value.description
# }

