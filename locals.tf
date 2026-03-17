# Wartości lokalne obliczane na podstawie zmiennych wejściowych.
# Używaj locals do wartości pochodnych, które chcesz wyliczyć raz
# i reużywać w wielu miejscach bez powtarzania logiki.

locals {
  # Prefiks "training-" zapewnia, że zasoby utworzone podczas szkolenia
  # są łatwo identyfikowalne i nie kolidują z istniejącymi zasobami.
  resource_prefix = "training"

  # Pełna nazwa repozytorium z prefiksem bezpieczeństwa.
  repository_full_name = "${local.resource_prefix}-${var.repository_name}"

  # Wspólne tagi/etykiety przekazywane do modułów.
  # W providerze GitHub nie ma koncepcji "tagów" jak w AWS/Azure,
  # ale możemy używać topics jako odpowiednika.
  common_topics = concat(
    ["terraform-training"],
    var.repository_topics,
  )
}

