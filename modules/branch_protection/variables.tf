# Zmienne wejściowe modułu branch_protection.
# ─────────────────────────────────────────────────────────────────────────────
# ĆWICZENIE: Ten moduł jest szkieletem do samodzielnej implementacji.
# Uzupełnij brakującą logikę w main.tf i outputs.tf.
# ─────────────────────────────────────────────────────────────────────────────

variable "repository" {
  description = "Name of the GitHub repository to protect."
  type        = string
}

variable "pattern" {
  description = "Branch name pattern to protect (e.g. 'main', 'release/*')."
  type        = string
  default     = "main"
}

variable "enforce_admins" {
  description = "Enforce branch protection rules for repository administrators."
  type        = bool
  default     = false
}

variable "required_status_checks" {
  description = "List of status check contexts required to pass before merging."
  type        = list(string)
  default     = []
}

variable "require_pull_request_reviews" {
  description = "Whether to require pull request reviews before merging."
  type        = bool
  default     = true
}

variable "required_approving_review_count" {
  description = "Number of required approving reviews before a pull request can be merged."
  type        = number
  default     = 1

  validation {
    condition     = var.required_approving_review_count >= 0 && var.required_approving_review_count <= 6
    error_message = "required_approving_review_count must be between 0 and 6."
  }
}

variable "dismiss_stale_reviews" {
  description = "Dismiss approved reviews automatically when new commits are pushed."
  type        = bool
  default     = true
}

variable "allow_force_pushes" {
  description = "Allow force pushes to the protected branch."
  type        = bool
  default     = false
}

variable "allow_deletions" {
  description = "Allow deletion of the protected branch."
  type        = bool
  default     = false
}

