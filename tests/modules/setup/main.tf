terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

module "container_app" {
  source = "../../.."

  product   = var.product
  component = var.component
  env       = var.env
  project   = var.project
  location  = var.location

  common_tags = var.common_tags

  log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  subnet_id                  = var.enable_vnet ? azurerm_subnet.test[0].id : null

  ingress_enabled          = var.ingress_enabled
  ingress_external_enabled = var.ingress_external_enabled
  ingress_target_port      = var.ingress_target_port
  ingress_transport        = var.ingress_transport

  containers = var.containers

  min_replicas = var.min_replicas
  max_replicas = var.max_replicas

  registry_server      = var.registry_server
  registry_identity_id = var.registry_identity_id

  key_vault_secrets = var.key_vault_secrets
}

# Supporting resources
resource "azurerm_log_analytics_workspace" "test" {
  name                = "${var.product}-${var.component}-${var.env}-law"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.common_tags
}

resource "azurerm_resource_group" "test" {
  name     = "${var.product}-${var.component}-${var.env}-rg"
  location = var.location
  tags     = var.common_tags
}

# VNet resources (optional)
resource "azurerm_virtual_network" "test" {
  count               = var.enable_vnet ? 1 : 0
  name                = "${var.product}-${var.component}-${var.env}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
  tags                = var.common_tags
}

resource "azurerm_subnet" "test" {
  count                = var.enable_vnet ? 1 : 0
  name                 = "container-app-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test[0].name
  address_prefixes     = ["10.0.1.0/23"]

  delegation {
    name = "container-app-delegation"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
