# tfmodule-azure-webapp-with-mapped-filestore

This module is intended to be used as a shared setup for anyone supporting applications needing a linux webapp hosting linux mapped to a filestore.

```terraform
locals {
  subscription_id = "[SUBID]"
}

provider "azurerm" {
  features {}
  alias           = "sub"
  subscription_id = local.subscription_id
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      configuration_aliases = [ azurerm.sub ]
    }
  }
  backend "azurerm" {
    storage_account_name = "[STATE_STORAGE_ACCOUNT]"
    container_name       = "tfstate"
    access_key           = "[STATE_STORAGE_ACCESS_KEY]"
    key                  = "site.tfstate"
  }
}

module "site" {
  source                            = "github.com/UKHO/tfmodule-azure-webapp-with-mapped-filestore?ref=v0.1.0"
  name                              = "[WEBAPP_NAME]"
  environment                       = "[ENVIRONMENT (DEV|QA|LIVE)]"
  resourcegroupname                 = "[WEBAPP_RG_NAME]"
  hosting_virtual_network_subnet_id = "[SUBNET_RESOURCE_ID]"
  tenant_id                         = "[TENANT_ID]"
  restricted_ip_address_or_range    = "[RESTRICTION_IPADDRESS]"
  providers = {
    azurerm.src = azurerm.sub
  }
}
```
