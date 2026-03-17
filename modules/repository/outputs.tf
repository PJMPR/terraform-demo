# Wartości wyjściowe modułu repository.
# Outputs eksportują dane zasobu, które mogą być użyte przez moduł nadrzędny
# lub inne moduły (np. branch_protection potrzebuje nazwy repozytorium).

output "name" {
  description = "The name of the created repository."
  value       = github_repository.this.name
}

output "full_name" {
  description = "Full name of the repository in the format 'owner/name'."
  value       = github_repository.this.full_name
}

output "html_url" {
  description = "URL to the repository on GitHub (browser link)."
  value       = github_repository.this.html_url
}

output "ssh_clone_url" {
  description = "SSH URL for cloning the repository."
  value       = github_repository.this.ssh_clone_url
}

output "http_clone_url" {
  description = "HTTPS URL for cloning the repository."
  value       = github_repository.this.http_clone_url
}

output "visibility" {
  description = "The visibility of the repository (public or private)."
  value       = github_repository.this.visibility
}

output "node_id" {
  description = "GitHub GraphQL node ID of the repository (used by some resources)."
  value       = github_repository.this.node_id
}

