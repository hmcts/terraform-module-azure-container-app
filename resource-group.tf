resource "azurerm_resource_group" "rg" {
  count = var.existing_resource_group_name == null ? 1 : 0

  name     = "${local.name}-type-${var.env}"
  location = var.location

  tags = var.common_tags
}

resource "azurerm_management_lock" "rg_lock" {
  count      = var.existing_resource_group_name == null ? 1 : 0
  name       = "resource-group-lock"
  scope      = azurerm_resource_group.rg[0].id
  lock_level = "CanNotDelete"
  notes      = "Prevent accidental deletion"

  depends_on = [azurerm_resource_group.rg]
}
