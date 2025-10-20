module "container_app" {
  source = "../"

  product   = "test"
  component = "nginx"
  env       = var.env
  project   = "sds"
  location  = "UK South"

  common_tags = {
    environment = var.env
    project     = "container-app-example"
    managedBy   = "terraform"
  }

  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  subnet_id                  = null # Set to azurerm_subnet.example[0].id if using VNet

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

# Supporting resources
resource "azurerm_log_analytics_workspace" "example" {
  name                = "test-nginx-${var.env}-law"
  location            = "UK South"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = var.env
    project     = "container-app-example"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "test-nginx-${var.env}-rg"
  location = "UK South"

  tags = {
    environment = var.env
    project     = "container-app-example"
  }
}
