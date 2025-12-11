output "container_app_ids" {
  description = "Map of container app names to their IDs"
  value       = module.multi_container_apps.container_app_ids
}

output "container_app_names" {
  description = "Map of container app keys to their names"
  value       = module.multi_container_apps.container_app_names
}

output "container_app_fqdns" {
  description = "Map of container app names to their FQDNs (null if ingress not enabled)"
  value       = module.multi_container_apps.container_app_fqdns
}

output "container_app_environment_id" {
  description = "The ID of the Container App Environment"
  value       = module.multi_container_apps.container_app_environment_id
}

output "container_app_identity_principal_id" {
  description = "The Principal ID of the Container App's managed identity"
  value       = module.multi_container_apps.container_app_identity_principal_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.multi_container_apps.resource_group_name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = module.multi_container_apps.resource_group_location
}
