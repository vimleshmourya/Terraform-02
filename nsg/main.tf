data "azurerm_subnet" "data-subnet" {
    for_each = var.nsg-map
  name                 = each.value.subnet-name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.vnet_resource_group_name
}


resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg-map
  name                = "${each.value.subnet-name}-nsg"
  location            = each.value.location
  resource_group_name = each.value.vnet_resource_group_name

  dynamic "security_rule" {
    for_each = each.value.securityrules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each            = var.nsg-map
  subnet_id           = data.azurerm_subnet.data-subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}