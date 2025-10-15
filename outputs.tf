output "container_app_id" {
  description = "The ID of the Container App"
  value       = azurerm_container_app.main.id
}

output "container_app_name" {
  description = "The name of the Container App"
  value       = azurerm_container_app.main.name
}

output "container_app_fqdn" {
  description = "The FQDN of the Container App"
  value       = var.ingress_enabled ? azurerm_container_app.main.ingress[0].fqdn : null
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
