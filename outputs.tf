# Wartości wyjściowe projektu.
# Outputs pozwalają wyeksportować dane o stworzonych zasobach,
# np. URL repozytorium po wykonaniu `terraform apply`.

output "repository_name" {
  description = "Full name of the created GitHub repository (with training- prefix)."
  value       = module.demo_repository.name
}

output "repository_url" {
  description = "HTTPS URL of the created GitHub repository."
  value       = module.demo_repository.html_url
}

output "repository_ssh_clone_url" {
  description = "SSH URL for cloning the created repository."
  value       = module.demo_repository.ssh_clone_url
}

output "repository_http_clone_url" {
  description = "HTTP URL for cloning the created repository."
  value       = module.demo_repository.http_clone_url
}

output "repository_visibility" {
  description = "Visibility of the created repository (public or private)."
  value       = module.demo_repository.visibility
}

# ──────────────────────────────────────────────
# Outputs z Data Sources
# ──────────────────────────────────────────────
# Poniższe outputy pokazują dane odczytane przez bloki `data` z data.tf.
# Są tylko do odczytu – Terraform nie zarządza tymi zasobami.

output "current_user_login" {
  description = "GitHub login of the authenticated user (owner of the PAT token)."
  value       = data.github_user.current.login
}

output "current_user_name" {
  description = "Display name of the authenticated GitHub user."
  value       = data.github_user.current.name
}

output "owner_public_repos" {
  description = "Number of public repositories on the owner's GitHub account."
  value       = data.github_user.owner.public_repos
}

output "demo_repo_default_branch" {
  description = "Default branch of the demo repository (read via data source)."
  value       = data.github_repository.demo.default_branch
}

output "demo_repo_topics" {
  description = "Topics assigned to the demo repository (read via data source)."
  value       = data.github_repository.demo.topics
}

output "main_branch_sha" {
  description = "SHA of the latest commit on the main branch (read via data source)."
  value       = data.github_branch.main.sha
}

