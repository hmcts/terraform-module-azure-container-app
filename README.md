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

| Name                                                               | Version  |
| ------------------------------------------------------------------ | -------- |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.7.0 |

## Providers

| Name                                                         | Version  |
| ------------------------------------------------------------ | -------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.7.0 |

## Resources

| Name                                                                                                                            | Type        |
| ------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)     | resource    |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name                                                                                                                  | Description                                                                                                 | Type          | Default      | Required |
| --------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ------------- | ------------ | :------: |
| <a name="input_common_tags"></a> [common_tags](#input_common_tags)                                                    | Common tag to be applied to resources.                                                                      | `map(string)` | n/a          |   yes    |
| <a name="input_component"></a> [component](#input_component)                                                          | https://hmcts.github.io/glossary/#component                                                                 | `string`      | n/a          |   yes    |
| <a name="input_env"></a> [env](#input_env)                                                                            | Environment value.                                                                                          | `string`      | n/a          |   yes    |
| <a name="input_existing_resource_group_name"></a> [existing_resource_group_name](#input_existing_resource_group_name) | Name of existing resource group to deploy resources into                                                    | `string`      | `null`       |    no    |
| <a name="input_location"></a> [location](#input_location)                                                             | Target Azure location to deploy the resource                                                                | `string`      | `"UK South"` |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                         | The default name will be product+component+env, you can override the product+component part by setting this | `string`      | `""`         |    no    |
| <a name="input_product"></a> [product](#input_product)                                                                | https://hmcts.github.io/glossary/#product                                                                   | `string`      | n/a          |   yes    |
| <a name="input_project"></a> [project](#input_project)                                                                | Project name - sds or cft.                                                                                  | `any`         | n/a          |   yes    |

## Outputs

| Name                                                                                                     | Description |
| -------------------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_resource_group_location"></a> [resource_group_location](#output_resource_group_location) | n/a         |
| <a name="output_resource_group_name"></a> [resource_group_name](#output_resource_group_name)             | n/a         |

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
