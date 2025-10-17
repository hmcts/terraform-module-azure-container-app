output "container_app_id" {
  description = "The ID of the Container App"
  value       = module.container_app.container_app_id
}

output "container_app_name" {
  description = "The name of the Container App"
  value       = module.container_app.container_app_name
}

output "container_app_fqdn" {
  description = "The FQDN of the Container App"
  value       = module.container_app.container_app_fqdn
}

output "container_app_environment_id" {
  description = "The ID of the Container App Environment"
  value       = module.container_app.container_app_environment_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.test.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.test.location
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.test.id
}
