resource "azurerm_resource_group" "rg" {
  provider = azurerm.sub
  name     = var.resourcegroupname
  location = var.location
  lifecycle {
    ignore_changes = [tags]
  }
}
