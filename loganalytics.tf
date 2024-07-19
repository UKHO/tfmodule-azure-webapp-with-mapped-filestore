resource "azurerm_log_analytics_workspace" "logs_analytics_workspace" {
  provider            = azurerm.src
  name                = "${var.name}-workspace"
  location            = var.location
  resource_group_name = var.resourcegroupname
  sku                 = "PerGB2018"
  retention_in_days   = 30
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_application_insights" "app_insights" {
  provider             = azurerm.src
  name                 = var.name
  location             = var.location
  resource_group_name  = var.resourcegroupname
  application_type     = "other"
  daily_data_cap_in_gb = 5
  workspace_id         = azurerm_log_analytics_workspace.logs_analytics_workspace.id
  lifecycle {
    ignore_changes = [tags]
  }
}
