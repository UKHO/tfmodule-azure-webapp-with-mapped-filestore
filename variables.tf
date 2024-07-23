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
  description = "An Array of CIDR Notation for the known IP Address range"
  default = []
}

variable "restricted_subnet_id" {
  description = "An array of subnet resource id"
  default = []
}

variable "restricted_default_action" {
  default = "Deny"
}

variable "hosting_virtual_network_subnet_id" {
}

variable "tenant_id" {
}
