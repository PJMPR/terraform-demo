# Zmienne wejściowe modułu labels.
# ─────────────────────────────────────────────────────────────────────────────
# ĆWICZENIE: Ten moduł jest szkieletem do samodzielnej implementacji.
# ─────────────────────────────────────────────────────────────────────────────

variable "repository" {
  description = "Name of the GitHub repository where labels will be created."
  type        = string
}

variable "labels" {
  description = "List of labels to create on the repository."
  type = list(object({
    name        = string
    color       = string
    description = optional(string, "")
  }))
  default = []

  # Walidacja formatu koloru – musi być 6-znakowym kodem HEX bez '#'
  validation {
    condition = alltrue([
      for label in var.labels :
      can(regex("^[0-9a-fA-F]{6}$", label.color))
    ])
    error_message = "Each label color must be a 6-character hex code without '#' (e.g. 'd73a4a')."
  }
}

