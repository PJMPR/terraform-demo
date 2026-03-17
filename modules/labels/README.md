# Module: `labels` *(Exercise)*

> ⚠️ **This module is an exercise skeleton.** It is not fully implemented yet.
> Your task is to complete the `main.tf` and `outputs.tf` files.

A Terraform module for managing GitHub issue labels on a repository.

## Exercise goal

Implement a module that:
- Accepts a list of labels (name, color, description)
- Creates each label on the specified repository using `for_each`
- Exports the created labels as outputs

## Usage (after implementation)

```hcl
module "demo_labels" {
  source = "./modules/labels"

  repository = module.demo_repository.name
  labels = [
    { name = "bug",         color = "d73a4a", description = "Something isn't working" },
    { name = "enhancement", color = "a2eeef", description = "New feature or request" },
    { name = "training",    color = "0075ca", description = "Created during training" },
    { name = "help wanted", color = "008672", description = "Extra attention is needed" },
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `repository` | Repository name | `string` | — | ✅ |
| `labels` | List of label objects `{ name, color, description }` | `list(object)` | `[]` | No |

## Outputs (to implement)

| Name | Description |
|------|-------------|
| `labels` | Map of all created label resources |
| `label_names` | List of created label names |

## Hints

- Resource to use: [`github_issue_label`](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label)
- Use `for_each` with a map transformation: `{ for label in var.labels : label.name => label }`
- Color must be a 6-char hex code **without** the `#` prefix
- After implementation, uncomment the module call in the root `main.tf`

