# Module: `repository`

A reusable Terraform module that creates and configures a GitHub repository.

## Usage

```hcl
module "my_repo" {
  source = "./modules/repository"

  name        = "training-my-project"
  description = "My demo repository created with Terraform."
  visibility  = "public"
  auto_init   = true
  topics      = ["terraform", "demo"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Full name of the repository | `string` | — | ✅ |
| `description` | Short description | `string` | `""` | No |
| `visibility` | `"public"` or `"private"` | `string` | `"public"` | No |
| `has_issues` | Enable Issues feature | `bool` | `true` | No |
| `has_wiki` | Enable Wiki feature | `bool` | `false` | No |
| `has_projects` | Enable Projects feature | `bool` | `false` | No |
| `auto_init` | Initialize with README.md | `bool` | `true` | No |
| `gitignore_template` | GitHub .gitignore template name | `string` | `""` | No |
| `license_template` | Open-source license template | `string` | `""` | No |
| `topics` | List of repository topics | `list(string)` | `[]` | No |
| `allow_merge_commit` | Allow merge commits | `bool` | `true` | No |
| `allow_squash_merge` | Allow squash merges | `bool` | `true` | No |
| `allow_rebase_merge` | Allow rebase merges | `bool` | `false` | No |
| `delete_branch_on_merge` | Auto-delete branches after merge | `bool` | `true` | No |

## Outputs

| Name | Description |
|------|-------------|
| `name` | Repository name |
| `full_name` | Full name (`owner/repo`) |
| `html_url` | Browser URL |
| `ssh_clone_url` | SSH clone URL |
| `http_clone_url` | HTTPS clone URL |
| `visibility` | Repository visibility |
| `node_id` | GitHub GraphQL node ID |

## Resources managed

| Resource | Purpose |
|----------|---------|
| `github_repository.this` | The GitHub repository |

