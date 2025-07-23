data "azurerm_subnet" "data-subnet" {
    for_each = var.vm-map
  name                 = each.value.subnet-name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.vnet_resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vm-map
  name                = "${each.value.vm-name}-nic-01"
  location            = each.value.location
  resource_group_name = each.value.vm_resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.data-subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vm-map
  name                            = each.value.vm-name
  resource_group_name             = each.value.vm_resource_group_name
  location                        = each.value.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd123!"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id, ]

  dynamic "os_disk" {
    for_each = each.value.os-disk
    content {
      name                 = "${each.value.vm-name}-os-disk"
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
    }
  }

  dynamic "source_image_reference" {
    for_each = each.value.source-image-reference
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }

  }
}
