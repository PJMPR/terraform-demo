# Zmienne wejściowe projektu.
# Każda zmienna powinna mieć: opis (description), typ (type) oraz opcjonalnie
# wartość domyślną (default) i walidację (validation).

# ──────────────────────────────────────────────
# Sekcja: Uwierzytelnianie
# ──────────────────────────────────────────────

variable "github_token" {
  description = "GitHub Personal Access Token (PAT) used to authenticate with the GitHub API."
  type        = string
  sensitive   = true
  # ZALECANE: Zamiast ustawiać tę wartość w terraform.tfvars, użyj zmiennej środowiskowej:
  #   export GITHUB_TOKEN="ghp_twój_token"
  # Terraform automatycznie mapuje zmienną środowiskową TF_VAR_github_token.
  #   export TF_VAR_github_token="ghp_twój_token"
}

variable "github_owner" {
  description = "GitHub username (owner) of the account where resources will be created."
  type        = string

  # Walidacja zapewnia, że wartość nie jest pusta.
  validation {
    condition     = length(var.github_owner) > 0
    error_message = "github_owner must not be empty."
  }
}

# ──────────────────────────────────────────────
# Sekcja: Konfiguracja repozytorium demo
# ──────────────────────────────────────────────

variable "repository_name" {
  description = "Base name of the demo repository. A 'training-' prefix will be added automatically."
  type        = string
  default     = "demo-repo"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.repository_name))
    error_message = "repository_name must contain only lowercase letters, digits and hyphens."
  }
}

variable "repository_description" {
  description = "Short description of the demo repository."
  type        = string
  default     = "Repository created during Terraform training."
}

variable "repository_visibility" {
  description = "Visibility of the repository: 'public' or 'private'."
  type        = string
  default     = "public"

  # Walidacja dopuszczalnych wartości.
  validation {
    condition     = contains(["public", "private"], var.repository_visibility)
    error_message = "repository_visibility must be either 'public' or 'private'."
  }
}

variable "repository_has_issues" {
  description = "Whether to enable the Issues feature on the repository."
  type        = bool
  default     = true
}

variable "repository_has_wiki" {
  description = "Whether to enable the Wiki feature on the repository."
  type        = bool
  default     = false
}

variable "repository_auto_init" {
  description = "Whether to initialize the repository with a README file."
  type        = bool
  default     = true
}

variable "repository_topics" {
  description = "List of topics (tags) to assign to the repository."
  type        = list(string)
  default     = ["terraform", "training", "demo"]
}

