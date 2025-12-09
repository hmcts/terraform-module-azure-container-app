output "container_app_ids" {
  description = "Map of container app names to their IDs"
  value       = { for k, v in azurerm_container_app.main : k => v.id }
}

output "container_app_names" {
  description = "Map of container app keys to their names"
  value       = { for k, v in azurerm_container_app.main : k => v.name }
}

output "container_app_fqdns" {
  description = "Map of container app names to their FQDNs (null if ingress not enabled)"
  value = {
    for k, v in azurerm_container_app.main :
    k => length(v.ingress) > 0 ? v.ingress[0].fqdn : null
  }
}

output "container_app_environment_id" {
  description = "The ID of the Container App Environment"
  value       = azurerm_container_app_environment.main.id
}

output "container_app_identity_principal_id" {
  description = "The Principal ID of the Container App's managed identity"
  value       = azurerm_user_assigned_identity.container_app.principal_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = local.resource_group_name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = local.resource_group_location
}
