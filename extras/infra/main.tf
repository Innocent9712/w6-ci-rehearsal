# A tiny Terraform configuration for trying CI on infrastructure code.
# It only writes a local file, so it needs no cloud account or credentials.

terraform {
  required_version = ">= 1.10"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9"
    }
  }
}

variable "environment" {
  description = "Which environment this is"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging or prod."
  }
}

resource "local_file" "config" {
  filename = "${path.module}/${var.environment}.txt"
  content  = "Managed by Terraform, checked by CI (${var.environment})\n"
}
