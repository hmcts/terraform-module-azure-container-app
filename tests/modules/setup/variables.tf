variable "product" {
  type    = string
  default = "test"
}

variable "component" {
  type    = string
  default = "nginx"
}

variable "env" {
  type    = string
  default = "test"
}

variable "project" {
  type    = string
  default = "sds"
}

variable "location" {
  type    = string
  default = "UK South"
}

variable "common_tags" {
  type = map(string)
  default = {
    environment = "test"
    project     = "test"
    managedBy   = "terraform"
  }
}

variable "enable_vnet" {
  type    = bool
  default = false
}

variable "container_apps" {
  description = "Map of container app configurations"
  type = map(object({
    revision_mode = optional(string, "Single")
    min_replicas  = optional(number, 0)
    max_replicas  = optional(number, 10)

    containers = map(object({
      image  = string
      cpu    = number
      memory = string
      env = list(object({
        name        = string
        secret_name = optional(string)
        value       = optional(string)
      }))
    }))

    key_vault_secrets = optional(list(object({
      name                  = string
      key_vault_id          = string
      key_vault_secret_name = string
    })), [])

    registry_identity_id = optional(string)
    registry_server      = optional(string)

    ingress_enabled                    = optional(bool, true)
    ingress_external_enabled           = optional(bool, true)
    ingress_target_port                = optional(number, 80)
    ingress_transport                  = optional(string, "auto")
    ingress_allow_insecure_connections = optional(bool, false)
  }))
  default = {
    main = {
      containers = {
        nginx = {
          image  = "nginx:alpine"
          cpu    = 0.25
          memory = "0.5Gi"
          env    = []
        }
      }
      ingress_enabled          = true
      ingress_external_enabled = true
      ingress_target_port      = 80
      ingress_transport        = "http"
      min_replicas             = 1
      max_replicas             = 3
    }
  }
}
