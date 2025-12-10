variable "existing_resource_group_name" {
  description = "Name of existing resource group to deploy resources into"
  type        = string
  default     = null
}

variable "location" {
  description = "Target Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "name" {
  default     = ""
  type        = string
  description = "The default name will be product+component+env, you can override the product+component part by setting this"
}

variable "subnet_id" {
  description = "Subnet ID for the Container App Environment"
  type        = string
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID for Container App Environment"
  type        = string
}

variable "internal_load_balancer_enabled" {
  description = "Enable internal load balancer"
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Enable zone redundancy"
  type        = bool
  default     = false
}

variable "environment_certificates" {
  description = "Map of Key Vault Secret IDs for certificates to be used in the Container App Environment."
  type        = map(string)
  default     = {}
}
