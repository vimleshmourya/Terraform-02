resource "azurerm_managed_disk" "data-disk-attach" {
  for_each             = var.data-disk-map
  name                 = each.value.disk-name
  location             = each.value.location
  resource_group_name  = each.value.vm_resource_group_name
  storage_account_type = each.value.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size_gb
}

