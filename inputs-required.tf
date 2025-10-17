variable "env" {
  description = "Environment value"
  type        = string
}

variable "common_tags" {
  description = "Common tag to be applied to resources"
  type        = map(string)
}

variable "product" {
  description = "https://hmcts.github.io/glossary/#product"
  type        = string
}

variable "project" {
  description = "Project name - sds or cft."
}

variable "component" {
  description = "https://hmcts.github.io/glossary/#component"
  type        = string
}

variable "containers" {
  description = "Container configuration"
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
