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

  enable_vnet = false

  container_apps = {
    main = {
      containers = {
        nginx = {
          image  = "nginx:alpine"
          cpu    = 0.25
          memory = "0.5Gi"
          env    = []
        }
      }

      ingress_enabled          = true
      ingress_external_enabled = true
      ingress_target_port      = 80
      ingress_transport        = "http"

      min_replicas = 1
      max_replicas = 3
    }
  }
}

# Outputs to verify deployment
output "container_app_fqdns" {
  description = "FQDNs of the deployed containers"
  value       = module.setup.container_app_fqdns
}

output "container_app_fqdn_main" {
  description = "FQDN of the main nginx container"
  value       = module.setup.container_app_fqdns["main"]
}

output "container_app_ids" {
  description = "IDs of the container apps"
  value       = module.setup.container_app_ids
}

output "container_app_names" {
  description = "Names of the container apps"
  value       = module.setup.container_app_names
}

output "resource_group_name" {
  description = "Resource group where resources are deployed"
  value       = module.setup.resource_group_name
}
