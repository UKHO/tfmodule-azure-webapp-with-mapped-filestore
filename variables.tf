data "azurerm_client_config" "current" {}

variable "location" {
  type    = string
  default = "UK South"
}

variable "resourcegroupname" {
  type = string
}

variable "name" {
  type = string
}

variable "sku_name" {
  type = string
  default = "B1"
}

variable "environment" {
  type = string
}

variable "restricted_ip_address_or_range" {
  description = "CIDR Notation for the known IP Address range"
  default = ""
}

variable "restricted_virtual_network_subnet_id" {
  default = ""
}

variable "hosting_virtual_network_subnet_id" {
}

locals {
  tenant_id = data.azurerm_client_config.current.tenant_id
}
