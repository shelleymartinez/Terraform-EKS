#---provider.tf/random_string---
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.2"
    }
  }
}