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

variable "service_owner" {
  type = string
}

variable "ip_address_or_range" {
  description = "CIDR Notation for the known IP Address range"
}

variable "subnet_name_restriction" {
  
}

variable "tenant_id" {
  default = data.azurerm_client_config.current.tenant_id
}
