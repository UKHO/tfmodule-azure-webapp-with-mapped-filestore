resource "azurerm_resource_group" "rg" {
  name     = var.resourcegroupname
  location = var.location
  lifecycle {
    ignore_changes = [ tags ]
  }
}