variable "rg-map" {}
variable "subnet-map" {}
variable "vm-map" {}
variable "vnet-map" {}
variable "data-disk-map" {}
variable "data-disk-attachment-map" {}
variable "bastion-map" {}
variable "nsg-map" {
  type = map(object({
    subnet-name              = string
    virtual_network_name     = string
    vnet_resource_group_name = string
    location                 = string
    securityrules = optional(map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })))
  }))
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}