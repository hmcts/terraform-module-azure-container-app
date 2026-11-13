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


variable "logging" {
  description = "Logging configuration for the Container App Environment"
  type = object({
    log_analytics_workspace_id  = string
    log_destination             = optional(string, "log-analytics")
    enabled_log_categories      = optional(list(string))
    enabled_log_category_groups = optional(list(string))
    enabled_metric_categories   = optional(list(string), ["AllMetrics"])
  })
  default = null

  validation {
    condition     = var.logging == null ? true : !(var.logging.enabled_log_categories != null && var.logging.enabled_log_category_groups != null)
    error_message = "Only one of logging.enabled_log_categories or logging.enabled_log_category_groups may be specified. If neither is set, the \"allLogs\" category group is used."
  }
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

variable "environment_storage" {
  description = "Map of storage accounts and shares for the Container App Environment."
  type = map(object({
    account_name = string
    share_name   = string
    access_key   = optional(string)
    access_mode  = optional(string, "ReadOnly")
  }))
  default = {}
}

variable "workload_profiles" {
  description = "Map of workload profiles for the Container App Environment."
  type = map(object({
    workload_profile_type = string
    minimum_count         = optional(number, 0)
    maximum_count         = optional(number, 5)
  }))
  default = {}
}
