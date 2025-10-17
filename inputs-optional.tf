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

variable "infrastructure_subnet_id" {
  description = "Infrastructure subnet ID for internal load balancer"
  type        = string
  default     = null
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

variable "ingress_enabled" {
  description = "Enable ingress"
  type        = bool
  default     = true
}

variable "ingress_external_enabled" {
  description = "Enable external ingress"
  type        = bool
  default     = true
}

variable "ingress_target_port" {
  description = "Target port for ingress"
  type        = number
  default     = 80
}

variable "ingress_transport" {
  description = "Transport protocol for ingress (http, http2, tcp, auto)"
  type        = string
  default     = "auto"

  validation {
    condition     = contains(["auto", "http", "http2", "tcp"], var.ingress_transport)
    error_message = "Transport must be one of: auto, http, http2, tcp"
  }
}

variable "ingress_allow_insecure_connections" {
  description = "Allow insecure connections to the ingress"
  type        = bool
  default     = false
}

variable "max_replicas" {
  description = "Maximum number of replicas"
  type        = number
  default     = 10
}

variable "min_replicas" {
  description = "Minimum number of replicas"
  type        = number
  default     = 0
}

variable "revision_mode" {
  description = "Revision mode (Single or Multiple)"
  type        = string
  default     = "Single"
}

variable "key_vault_secrets" {
  description = "List of Key Vault secrets to reference"
  type = list(object({
    name                  = string
    key_vault_id          = string
    key_vault_secret_name = string
  }))
  default = []
}

variable "registry_identity_id" {
  description = "User Assigned Identity ID for pulling images from ACR"
  type        = string
  default     = null
}

variable "workload_profile_name" {
  description = "Workload profile name"
  type        = string
  default     = null
}

variable "registry_server" {
  description = "Container registry server, e.g. myregistry.azurecr.io"
  type        = string
  default     = null
}
