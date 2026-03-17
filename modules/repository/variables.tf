# Zmienne wejściowe modułu repository.

variable "name" {
  description = "Full name of the GitHub repository (including any prefix)."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]+$", var.name))
    error_message = "Repository name must only contain alphanumeric characters, hyphens, underscores, or dots."
  }
}

variable "description" {
  description = "Short description of the repository."
  type        = string
  default     = ""
}

variable "visibility" {
  description = "Repository visibility: 'public' or 'private'."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "visibility must be 'public' or 'private'."
  }
}

variable "has_issues" {
  description = "Enable GitHub Issues on this repository."
  type        = bool
  default     = true
}

variable "has_wiki" {
  description = "Enable GitHub Wiki on this repository."
  type        = bool
  default     = false
}

variable "has_projects" {
  description = "Enable GitHub Projects on this repository."
  type        = bool
  default     = false
}

variable "auto_init" {
  description = "Initialize the repository with a README.md file."
  type        = bool
  default     = true
}

variable "gitignore_template" {
  description = "GitHub's .gitignore template to apply (e.g. 'Terraform', 'Go', 'Python'). Leave empty to skip."
  type        = string
  default     = ""
}

variable "license_template" {
  description = "Open-source license template to apply (e.g. 'mit', 'apache-2.0'). Leave empty to skip."
  type        = string
  default     = ""
}

variable "topics" {
  description = "List of topics (tags) to assign to the repository."
  type        = list(string)
  default     = []
}

variable "allow_merge_commit" {
  description = "Allow merge commits on pull requests."
  type        = bool
  default     = true
}

variable "allow_squash_merge" {
  description = "Allow squash merging on pull requests."
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Allow rebase merging on pull requests."
  type        = bool
  default     = false
}

variable "delete_branch_on_merge" {
  description = "Automatically delete head branches after pull requests are merged."
  type        = bool
  default     = true
}

