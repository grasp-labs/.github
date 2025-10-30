# Grasp Labs Organization Repository

Welcome to the Grasp Labs organization repository! This repository contains default documents, policies, and reusable workflows for all repositories in the organization.

## 🔧 Reusable Workflows

We provide modular, reusable workflows that any repository in the organization can use for linting and validation.

### 📋 Available Workflows

| Workflow | Purpose | Usage |
|----------|---------|-------|
| **`lint-python.yml`** | Python linting with flake8, black, isort, mypy | `uses: grasp-labs/.github/.github/workflows/lint-python.yml@main` |
| **`lint-javascript.yml`** | JS/TS linting with ESLint and Prettier | `uses: grasp-labs/.github/.github/workflows/lint-javascript.yml@main` |
| **`lint-go.yml`** | Go linting with golangci-lint, go vet, go fmt | `uses: grasp-labs/.github/.github/workflows/lint-go.yml@main` |
| **`lint-rust.yml`** | Rust linting with rustfmt, clippy | `uses: grasp-labs/.github/.github/workflows/lint-rust.yml@main` |
| **`lint-terraform.yml`** | Terraform linting with TFLint + custom rules | `uses: grasp-labs/.github/.github/workflows/lint-terraform.yml@main` |
| **`lint-markdown.yml`** | Markdown linting with markdownlint | `uses: grasp-labs/.github/.github/workflows/lint-markdown.yml@main` |
| **`lint-yaml.yml`** | YAML linting with yamllint | `uses: grasp-labs/.github/.github/workflows/lint-yaml.yml@main` |
| **`validate-codeowners.yml`** | CODEOWNERS file validation | `uses: grasp-labs/.github/.github/workflows/validate-codeowners.yml@main` |
| **`lint.yml`** | **All languages** - Runs all applicable lints | `uses: grasp-labs/.github/.github/workflows/lint.yml@main` |

### 🏗️ Terraform Linting Rules

Our Terraform workflow enforces essential organization-specific rules:

- **✅ Backend Bucket Rule**: All S3 backends must use bucket `grasptfstates`
- **✅ Locals Block Validation**: Required locals structure and naming conventions
  - `domain` must be `"ds"`
  - `service_group_name` must be one of: `"core"`, `"consumption"`, `"auxiliary"`
  - Required fields: `service_group_name`, `environment`, `base_name`, `app`
  - `base_name` must follow: `"${local.domain}-${local.service_group_name}-${local.service_name}"`
  - `app` must follow: `"${local.domain}-${local.service_group_name}-${local.service_name}-${local.environment}"`
- **✅ Resource Tagging**: Required tags: Environment, Project
- **✅ Naming Convention**: snake_case for all resources
- **✅ Type Safety**: Variables must have explicit types
- **✅ AWS Instance Types**: Validates instance types are current

### 🚀 Quick Start Examples

**Terraform Repository:**
```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]

jobs:
  terraform-lint:
    uses: grasp-labs/.github/.github/workflows/lint-terraform.yml@main
    with:
      terraform-version: '1.6.0'
      working-directory: './infrastructure'
```

**Multi-Language Repository:**
```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]

jobs:
  lint-all:
    uses: grasp-labs/.github/.github/workflows/lint.yml@main
```

**Custom Terraform Configuration:**
```yaml
# .github/workflows/terraform.yml
name: Terraform
on: [push, pull_request]

jobs:
  terraform-lint:
    uses: grasp-labs/.github/.github/workflows/lint-terraform.yml@main
    with:
      terraform-version: '1.6.0'
      tflint-version: 'v0.48.0'
      working-directory: './terraform'
      config-file: '.tflint.hcl'
```

### ⚙️ Workflow Inputs

**Terraform Workflow Inputs:**
- **`terraform-version`** - Terraform version (default: 'latest')
- **`tflint-version`** - TFLint version (default: 'latest')
- **`working-directory`** - Directory containing Terraform files (default: '.')
- **`config-file`** - TFLint configuration file (default: '.tflint.hcl')

### 📝 Configuration Files

The following configuration files are embedded in workflows and automatically downloaded when needed:

- **`.github/workflows/configs/.tflint.hcl`** - TFLint rules and organization standards

Repositories can override these by placing their own configuration files in their root directory.
