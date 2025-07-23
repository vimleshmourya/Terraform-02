data "azurerm_subnet" "data-subnet" {
    for_each = var.bastion-map
  name                 = each.value.subnet-name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.vnet_resource_group_name
}


resource "azurerm_public_ip" "pip" {
    for_each            = var.bastion-map
  name                = "${each.value.bastion-name}-pip"
  location            = each.value.location
  resource_group_name = each.value.vnet_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
    for_each            = var.bastion-map
  name                = each.value.bastion-name
  location            = each.value.location
  resource_group_name = each.value.vnet_resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip-configuration
    content {
      name                 = ip_configuration.value.name
      subnet_id            = data.azurerm_subnet.data-subnet[each.key].id
      public_ip_address_id = azurerm_public_ip.pip[each.key].id
    }
  }
}