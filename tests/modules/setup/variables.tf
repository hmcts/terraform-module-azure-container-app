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
variable "ingress_enabled" {
  type    = bool
  default = true
}

variable "ingress_external_enabled" {
  type    = bool
  default = true
}

variable "ingress_target_port" {
  type    = number
  default = 80
}

variable "ingress_transport" {
  type    = string
  default = "http"
}

variable "containers" {
  type = map(object({
    image  = string
    cpu    = number
    memory = string
    env = optional(list(object({
      name        = string
      secret_name = optional(string)
      value       = optional(string)
    })), [])
  }))
  default = {
    nginx = {
      image  = "nginx:alpine"
      cpu    = 0.25
      memory = "0.5Gi"
      env    = []
    }
  }
}

variable "min_replicas" {
  type    = number
  default = 1
}

variable "max_replicas" {
  type    = number
  default = 3
}

variable "registry_server" {
  type    = string
  default = null
}

variable "registry_identity_id" {
  type    = string
  default = null
}

variable "key_vault_secrets" {
  type = list(object({
    name                  = string
    key_vault_id          = string
    key_vault_secret_name = string
  }))
  default = []
}
