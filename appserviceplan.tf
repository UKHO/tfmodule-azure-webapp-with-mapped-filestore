resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.name}-asp"
  location            = var.location
  resource_group_name = var.resourcegroupname
  sku_name            = var.sku_name
  os_type             = "Linux"
  lifecycle {
    ignore_changes = [ tags ]
  }
}