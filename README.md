# terraform-module-template

<!-- TODO fill in resource name in link to product documentation -->

Terraform module for [Resource name](https://example.com).

## Example

<!-- todo update module name -->

```hcl
module "todo_resource_name" {
  source = "git@github.com:hmcts/terraform-module-todo?ref=main"
  ...
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.7.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.7.0 >= 3.70.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app) | resource |
| [azurerm_container_app_environment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_user_assigned_identity.container_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_key_vault_secret.secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_resource_group.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_component"></a> [component](#input\_component) | https://hmcts.github.io/glossary/#component | `string` | n/a | yes |
| <a name="input_containers"></a> [containers](#input\_containers) | Container configuration | <pre>map(object({<br/>    image  = string<br/>    cpu    = number<br/>    memory = string<br/>    env = optional(list(object({<br/>      name        = string<br/>      secret_name = optional(string)<br/>      value       = optional(string)<br/>    })), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment value | `string` | n/a | yes |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Name of existing resource group to deploy resources into | `string` | `null` | no |
| <a name="input_infrastructure_subnet_id"></a> [infrastructure\_subnet\_id](#input\_infrastructure\_subnet\_id) | Infrastructure subnet ID for internal load balancer | `string` | `null` | no |
| <a name="input_ingress_allow_insecure_connections"></a> [ingress\_allow\_insecure\_connections](#input\_ingress\_allow\_insecure\_connections) | Allow insecure connections to the ingress | `bool` | `false` | no |
| <a name="input_ingress_enabled"></a> [ingress\_enabled](#input\_ingress\_enabled) | Enable ingress | `bool` | `true` | no |
| <a name="input_ingress_external_enabled"></a> [ingress\_external\_enabled](#input\_ingress\_external\_enabled) | Enable external ingress | `bool` | `true` | no |
| <a name="input_ingress_target_port"></a> [ingress\_target\_port](#input\_ingress\_target\_port) | Target port for ingress | `number` | `80` | no |
| <a name="input_ingress_transport"></a> [ingress\_transport](#input\_ingress\_transport) | Transport protocol for ingress (http, http2, tcp, auto) | `string` | `"auto"` | no |
| <a name="input_internal_load_balancer_enabled"></a> [internal\_load\_balancer\_enabled](#input\_internal\_load\_balancer\_enabled) | Enable internal load balancer | `bool` | `false` | no |
| <a name="input_key_vault_secrets"></a> [key\_vault\_secrets](#input\_key\_vault\_secrets) | List of Key Vault secrets to reference | <pre>list(object({<br/>    name                  = string<br/>    key_vault_id          = string<br/>    key_vault_secret_name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Target Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Log Analytics Workspace ID for Container App Environment | `string` | n/a | yes |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Maximum number of replicas | `number` | `10` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Minimum number of replicas | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | The default name will be product+component+env, you can override the product+component part by setting this | `string` | `""` | no |
| <a name="input_product"></a> [product](#input\_product) | https://hmcts.github.io/glossary/#product | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name - sds or cft. | `any` | n/a | yes |
| <a name="input_registry_identity_id"></a> [registry\_identity\_id](#input\_registry\_identity\_id) | User Assigned Identity ID for pulling images from ACR | `string` | `null` | no |
| <a name="input_revision_mode"></a> [revision\_mode](#input\_revision\_mode) | Revision mode (Single or Multiple) | `string` | `"Single"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID for the Container App Environment | `string` | `null` | no |
| <a name="input_workload_profile_name"></a> [workload\_profile\_name](#input\_workload\_profile\_name) | Workload profile name | `string` | `null` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Enable zone redundancy | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_app_environment_id"></a> [container\_app\_environment\_id](#output\_container\_app\_environment\_id) | The ID of the Container App Environment |
| <a name="output_container_app_fqdn"></a> [container\_app\_fqdn](#output\_container\_app\_fqdn) | The FQDN of the Container App |
| <a name="output_container_app_id"></a> [container\_app\_id](#output\_container\_app\_id) | The ID of the Container App |
| <a name="output_container_app_identity_principal_id"></a> [container\_app\_identity\_principal\_id](#output\_container\_app\_identity\_principal\_id) | The Principal ID of the Container App's managed identity |
| <a name="output_container_app_name"></a> [container\_app\_name](#output\_container\_app\_name) | The name of the Container App |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | The location of the resource group |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:

```shell
$ pre-commit run --all-files
```

# Integration Tests

This directory contains integration tests for the Azure Container App Terraform module.

## Test Structure

- `test.tf` - Main test configuration that deploys an nginx container
- `modules/setup/` - Helper module that creates supporting infrastructure

## Running Tests Locally

### Prerequisites

- Terraform >= 1.5.0
- Azure CLI logged in
- Appropriate Azure permissions

### Run Tests

```bash
cd tests

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply (creates resources in Azure)
terraform apply

# Get the FQDN and test the nginx container
FQDN=$(terraform output -raw container_app_fqdn)
curl "https://$FQDN"

# Clean up
terraform destroy
```
