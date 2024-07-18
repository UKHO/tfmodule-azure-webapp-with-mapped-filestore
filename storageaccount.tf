resource "azurerm_storage_account" "rooted_storage" {
  provider            = azurerm.sub
  name                = replace("${var.name}sa", "-", "")
  location            = var.location
  resource_group_name = var.resourcegroupname

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"

  enable_https_traffic_only = true

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_storage_share_directory" "spool_share_directory" {
  provider         = azurerm.sub
  name             = "spool"
  storage_share_id = azurerm_storage_share.rooted_storage_fileshare.id
}

resource "azurerm_storage_share" "rooted_storage_fileshare" {
  provider             = azurerm.sub
  name                 = "workspaceroot"
  storage_account_name = azurerm_storage_account.rooted_storage.name
  quota                = 50
}

resource "azurerm_storage_share_directory" "workspaces_share_directory" {
  provider         = azurerm.sub
  name             = "workspaces"
  storage_share_id = azurerm_storage_share.rooted_storage_fileshare.id
}
