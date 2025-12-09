locals {
  name = var.name != "" ? var.name : "${var.product}-${var.component}"

  resource_group_name     = var.existing_resource_group_name == null ? azurerm_resource_group.rg[0].name : var.existing_resource_group_name
  resource_group_location = var.existing_resource_group_name == null ? azurerm_resource_group.rg[0].location : data.azurerm_resource_group.existing[0].location

  tags = merge(var.common_tags, {
    project = var.project
  })

  consumption_workload_profile_name = "Consumption"

  # Flatten all key vault secrets from all container apps for data source lookup
  all_key_vault_secrets = merge([
    for app_key, app in var.container_apps : {
      for secret in app.key_vault_secrets :
      "${app_key}-${secret.name}" => secret
    }
  ]...)
}

data "azurerm_resource_group" "existing" {
  count = var.existing_resource_group_name != null ? 1 : 0
  name  = var.existing_resource_group_name
}

