data "azurerm_virtual_machine" "data-vm" {
    for_each = var.data-disk-attachment-map
  name                = each.value.vm-name
  resource_group_name = each.value.vm_resource_group_name
}

data "azurerm_managed_disk" "data-managed-disk" {
    for_each = var.data-disk-attachment-map
  name                = each.value.managed-disk-name
  resource_group_name = each.value.vm_resource_group_name
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk-attachment" {
  for_each           = var.data-disk-attachment-map
  managed_disk_id    = data.azurerm_managed_disk.data-managed-disk[each.key].id
  virtual_machine_id = data.azurerm_virtual_machine.data-vm[each.key].id
  lun                = each.value.lun
  caching            = "ReadWrite"
}
