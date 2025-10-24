terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Setup module creates supporting infrastructure
module "setup" {
  source = "./modules/setup"

  product   = "test"
  component = "nginx"
  env       = "test"
  project   = "sds"
  location  = "UK South"

  common_tags = {
    environment = "test"
    project     = "container-app-test"
    managedBy   = "terraform"
  }

  enable_vnet              = false
  ingress_enabled          = true
  ingress_external_enabled = true
  ingress_target_port      = 80
  ingress_transport        = "http"

  containers = {
    nginx = {
      image  = "nginx:alpine"
      cpu    = 0.25
      memory = "0.5Gi"
      env    = []
    }
  }

  min_replicas = 1
  max_replicas = 3
}

# Outputs to verify deployment
output "container_app_fqdn" {
  description = "FQDN of the deployed nginx container"
  value       = module.setup.container_app_fqdn
}

output "container_app_id" {
  description = "ID of the container app"
  value       = module.setup.container_app_id
}

output "container_app_name" {
  description = "Name of the container app"
  value       = module.setup.container_app_name
}

output "resource_group_name" {
  description = "Resource group where resources are deployed"
  value       = module.setup.resource_group_name
}
