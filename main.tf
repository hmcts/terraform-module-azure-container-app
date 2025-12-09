resource "azurerm_user_assigned_identity" "container_app" {
  name                = "${local.name}-${var.env}-identity"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  tags                = local.tags
}

resource "azurerm_container_app_environment" "main" {
  name                           = "${local.name}-${var.env}-env"
  location                       = local.resource_group_location
  resource_group_name            = local.resource_group_name
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  infrastructure_subnet_id       = var.subnet_id
  internal_load_balancer_enabled = var.internal_load_balancer_enabled
  zone_redundancy_enabled        = var.zone_redundancy_enabled

  workload_profile {
    name                  = local.consumption_workload_profile_name
    workload_profile_type = "Consumption"
  }

  tags = local.tags
}

data "azurerm_key_vault_secret" "secrets" {
  for_each = local.all_key_vault_secrets

  name         = each.value.key_vault_secret_name
  key_vault_id = each.value.key_vault_id
}

resource "azurerm_container_app" "main" {
  for_each = var.container_apps

  name                         = "${local.name}-${each.key}-${var.env}"
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = local.resource_group_name
  revision_mode                = each.value.revision_mode
  workload_profile_name        = local.consumption_workload_profile_name
  tags                         = local.tags

  identity {
    type         = each.value.registry_identity_id != null ? "UserAssigned" : "SystemAssigned"
    identity_ids = each.value.registry_identity_id != null ? [each.value.registry_identity_id] : null
  }

  dynamic "registry" {
    for_each = each.value.registry_identity_id != null && each.value.registry_server != null ? [1] : []
    content {
      server   = each.value.registry_server
      identity = each.value.registry_identity_id
    }
  }

  template {
    min_replicas = each.value.min_replicas
    max_replicas = each.value.max_replicas

    dynamic "container" {
      for_each = each.value.containers
      content {
        name   = container.key
        image  = container.value.image
        cpu    = container.value.cpu
        memory = container.value.memory

        dynamic "env" {
          for_each = container.value.env
          content {
            name        = env.value.name
            secret_name = try(env.value.secret_name, null)
            value       = try(env.value.value, null)
          }
        }
      }
    }
  }

  dynamic "secret" {
    for_each = each.value.key_vault_secrets
    content {
      name  = secret.value.name
      value = data.azurerm_key_vault_secret.secrets["${each.key}-${secret.value.name}"].value
    }
  }

  dynamic "ingress" {
    for_each = each.value.ingress_enabled ? [1] : []
    content {
      external_enabled           = each.value.ingress_external_enabled
      target_port                = each.value.ingress_target_port
      transport                  = each.value.ingress_transport
      allow_insecure_connections = each.value.ingress_allow_insecure_connections

      traffic_weight {
        latest_revision = true
        percentage      = 100
      }
    }
  }
}
