resource "azurerm_resource_group" "rg" {
  provider = azurerm.src
  name     = var.resourcegroupname
  location = var.location
  lifecycle {
    ignore_changes = [tags]
  }
}
