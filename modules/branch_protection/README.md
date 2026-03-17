# Module: `branch_protection` *(Exercise)*

> ⚠️ **This module is an exercise skeleton.** It is not fully implemented yet.
> Your task is to complete the `main.tf` and `outputs.tf` files.

A Terraform module for configuring branch protection rules on a GitHub repository.

## Exercise goal

Implement branch protection that:
- Requires at least 1 approving review before merging
- Dismisses stale reviews when new commits are pushed
- Prevents force-pushes to the protected branch
- Prevents deletion of the protected branch

## Usage (after implementation)

```hcl
module "branch_protection" {
  source = "./modules/branch_protection"

  repository     = module.demo_repository.name
  pattern        = "main"
  enforce_admins = false

  require_pull_request_reviews    = true
  required_approving_review_count = 1
  dismiss_stale_reviews           = true
  allow_force_pushes              = false
  allow_deletions                 = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `repository` | Repository name to protect | `string` | — | ✅ |
| `pattern` | Branch pattern (e.g. `main`) | `string` | `"main"` | No |
| `enforce_admins` | Enforce rules for admins | `bool` | `false` | No |
| `required_status_checks` | Required CI check contexts | `list(string)` | `[]` | No |
| `require_pull_request_reviews` | Require PR reviews | `bool` | `true` | No |
| `required_approving_review_count` | Number of required approvals | `number` | `1` | No |
| `dismiss_stale_reviews` | Dismiss stale reviews on new push | `bool` | `true` | No |
| `allow_force_pushes` | Allow force pushes | `bool` | `false` | No |
| `allow_deletions` | Allow branch deletion | `bool` | `false` | No |

## Hints

- Resource to use: [`github_branch_protection`](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection)
- `repository_id` can be taken from `module.demo_repository.node_id`
- After implementation, uncomment the module call in the root `main.tf`

