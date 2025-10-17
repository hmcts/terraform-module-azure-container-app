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

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0  |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >= 3.7.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >= 3.70.0 |

## Providers

| Name                                                         | Version            |
| ------------------------------------------------------------ | ------------------ |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.7.0 >= 3.70.0 |

## Resources

| Name                                                                                                                                                   | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [azurerm_container_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app)                            | resource    |
| [azurerm_container_app_environment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment)    | resource    |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)                            | resource    |
| [azurerm_user_assigned_identity.container_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource    |
| [azurerm_key_vault_secret.secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret)                | data source |
| [azurerm_resource_group.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                   | data source |

## Inputs

| Name                                                                                                                                    | Description                                                                                                 | Type                                                                                                                                                                                                                                                 | Default      | Required |
| --------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | :------: |
| <a name="input_common_tags"></a> [common_tags](#input_common_tags)                                                                      | Common tag to be applied to resources                                                                       | `map(string)`                                                                                                                                                                                                                                        | n/a          |   yes    |
| <a name="input_component"></a> [component](#input_component)                                                                            | https://hmcts.github.io/glossary/#component                                                                 | `string`                                                                                                                                                                                                                                             | n/a          |   yes    |
| <a name="input_containers"></a> [containers](#input_containers)                                                                         | Container configuration                                                                                     | <pre>list(object({<br/> name = string<br/> image = string<br/> cpu = number<br/> memory = string<br/> env = optional(list(object({<br/> name = string<br/> secret_name = optional(string)<br/> value = optional(string)<br/> })), [])<br/> }))</pre> | n/a          |   yes    |
| <a name="input_env"></a> [env](#input_env)                                                                                              | Environment value                                                                                           | `string`                                                                                                                                                                                                                                             | n/a          |   yes    |
| <a name="input_existing_resource_group_name"></a> [existing_resource_group_name](#input_existing_resource_group_name)                   | Name of existing resource group to deploy resources into                                                    | `string`                                                                                                                                                                                                                                             | `null`       |    no    |
| <a name="input_infrastructure_subnet_id"></a> [infrastructure_subnet_id](#input_infrastructure_subnet_id)                               | Infrastructure subnet ID for internal load balancer                                                         | `string`                                                                                                                                                                                                                                             | `null`       |    no    |
| <a name="input_ingress_allow_insecure_connections"></a> [ingress_allow_insecure_connections](#input_ingress_allow_insecure_connections) | Allow insecure connections to the ingress                                                                   | `bool`                                                                                                                                                                                                                                               | `false`      |    no    |
| <a name="input_ingress_enabled"></a> [ingress_enabled](#input_ingress_enabled)                                                          | Enable ingress                                                                                              | `bool`                                                                                                                                                                                                                                               | `true`       |    no    |
| <a name="input_ingress_external_enabled"></a> [ingress_external_enabled](#input_ingress_external_enabled)                               | Enable external ingress                                                                                     | `bool`                                                                                                                                                                                                                                               | `true`       |    no    |
| <a name="input_ingress_target_port"></a> [ingress_target_port](#input_ingress_target_port)                                              | Target port for ingress                                                                                     | `number`                                                                                                                                                                                                                                             | `80`         |    no    |
| <a name="input_ingress_transport"></a> [ingress_transport](#input_ingress_transport)                                                    | Transport protocol for ingress (http, http2, tcp, auto)                                                     | `string`                                                                                                                                                                                                                                             | `"auto"`     |    no    |
| <a name="input_internal_load_balancer_enabled"></a> [internal_load_balancer_enabled](#input_internal_load_balancer_enabled)             | Enable internal load balancer                                                                               | `bool`                                                                                                                                                                                                                                               | `false`      |    no    |
| <a name="input_key_vault_secrets"></a> [key_vault_secrets](#input_key_vault_secrets)                                                    | List of Key Vault secrets to reference                                                                      | <pre>list(object({<br/> name = string<br/> key_vault_id = string<br/> key_vault_secret_name = string<br/> }))</pre>                                                                                                                                  | `[]`         |    no    |
| <a name="input_location"></a> [location](#input_location)                                                                               | Target Azure location to deploy the resource                                                                | `string`                                                                                                                                                                                                                                             | `"UK South"` |    no    |
| <a name="input_log_analytics_workspace_id"></a> [log_analytics_workspace_id](#input_log_analytics_workspace_id)                         | Log Analytics Workspace ID for Container App Environment                                                    | `string`                                                                                                                                                                                                                                             | n/a          |   yes    |
| <a name="input_max_replicas"></a> [max_replicas](#input_max_replicas)                                                                   | Maximum number of replicas                                                                                  | `number`                                                                                                                                                                                                                                             | `10`         |    no    |
| <a name="input_min_replicas"></a> [min_replicas](#input_min_replicas)                                                                   | Minimum number of replicas                                                                                  | `number`                                                                                                                                                                                                                                             | `0`          |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                                           | The default name will be product+component+env, you can override the product+component part by setting this | `string`                                                                                                                                                                                                                                             | `""`         |    no    |
| <a name="input_product"></a> [product](#input_product)                                                                                  | https://hmcts.github.io/glossary/#product                                                                   | `string`                                                                                                                                                                                                                                             | n/a          |   yes    |
| <a name="input_project"></a> [project](#input_project)                                                                                  | Project name - sds or cft.                                                                                  | `any`                                                                                                                                                                                                                                                | n/a          |   yes    |
| <a name="input_registry_identity_id"></a> [registry_identity_id](#input_registry_identity_id)                                           | User Assigned Identity ID for pulling images from ACR                                                       | `string`                                                                                                                                                                                                                                             | `null`       |    no    |
| <a name="input_revision_mode"></a> [revision_mode](#input_revision_mode)                                                                | Revision mode (Single or Multiple)                                                                          | `string`                                                                                                                                                                                                                                             | `"Single"`   |    no    |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id)                                                                            | Subnet ID for the Container App Environment                                                                 | `string`                                                                                                                                                                                                                                             | `null`       |    no    |
| <a name="input_workload_profile_name"></a> [workload_profile_name](#input_workload_profile_name)                                        | Workload profile name                                                                                       | `string`                                                                                                                                                                                                                                             | `null`       |    no    |
| <a name="input_zone_redundancy_enabled"></a> [zone_redundancy_enabled](#input_zone_redundancy_enabled)                                  | Enable zone redundancy                                                                                      | `bool`                                                                                                                                                                                                                                               | `false`      |    no    |

## Outputs

| Name                                                                                                                                         | Description                                              |
| -------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| <a name="output_container_app_environment_id"></a> [container_app_environment_id](#output_container_app_environment_id)                      | The ID of the Container App Environment                  |
| <a name="output_container_app_fqdn"></a> [container_app_fqdn](#output_container_app_fqdn)                                                    | The FQDN of the Container App                            |
| <a name="output_container_app_id"></a> [container_app_id](#output_container_app_id)                                                          | The ID of the Container App                              |
| <a name="output_container_app_identity_principal_id"></a> [container_app_identity_principal_id](#output_container_app_identity_principal_id) | The Principal ID of the Container App's managed identity |
| <a name="output_container_app_name"></a> [container_app_name](#output_container_app_name)                                                    | The name of the Container App                            |
| <a name="output_resource_group_location"></a> [resource_group_location](#output_resource_group_location)                                     | The location of the resource group                       |
| <a name="output_resource_group_name"></a> [resource_group_name](#output_resource_group_name)                                                 | The name of the resource group                           |

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
