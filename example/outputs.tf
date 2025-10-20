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

output "container_app_url" {
  description = "Full URL to access the nginx container"
  value       = module.container_app.container_app_fqdn != null ? "https://${module.container_app.container_app_fqdn}" : null
}

output "container_app_environment_id" {
  description = "The ID of the Container App Environment"
  value       = module.container_app.container_app_environment_id
}

output "container_app_identity_principal_id" {
  description = "The Principal ID of the Container App's managed identity"
  value       = module.container_app.container_app_identity_principal_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.container_app.resource_group_name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = module.container_app.resource_group_location
}
