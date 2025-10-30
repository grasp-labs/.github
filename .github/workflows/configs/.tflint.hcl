# TFLint configuration file for Grasp Labs organization
# See https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md

config {
  # Disable all rules by default, enable only what we need
  disabled_by_default = true

  # Format for output
  format = "compact"
}

# AWS plugin for additional AWS-specific rules
plugin "aws" {
  enabled = true
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Essential Terraform core rules
rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

# Essential AWS rules
rule "aws_instance_invalid_type" {
  enabled = true
}

rule "aws_resource_missing_tags" {
  enabled = true
  tags = ["Environment", "Project"]
}

# ORGANIZATION RULES: Custom Validation (enforced by workflow script)
# These rules are enforced by custom validation scripts in lint-terraform.yml workflow
# (TFLint does not support these specific validations natively)

# 1. Backend Bucket Validation
#    - All S3 backends must use bucket 'grasptfstates'

# 2. Locals Block Validation
#    - domain must be "ds"
#    - service_group_name must be one of: "core", "consumption", "auxiliary"
#    - Required fields: service_group_name, environment, base_name, app
#    - base_name must follow: "${local.domain}-${local.service_group_name}-${local.service_name}"
#    - app must follow: "${local.domain}-${local.service_group_name}-${local.service_name}-${local.environment}"
