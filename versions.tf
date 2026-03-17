# Określamy minimalną i maksymalną wersję Terraform oraz wymaganego providera.
# Pinowanie wersji zapobiega nieoczekiwanym zmianom przy aktualizacjach.

terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    github = {
      source  = "integrations/github"
      # Przypinamy konkretną wersję providera GitHub, aby szkolenie było powtarzalne.
      version = "~> 6.6"
    }
  }
}

