resource "azurerm_resource_group" "rg" {
    for_each = var.rg-map
  name     = each.value.name
  location = each.value.location
  tags     = merge(local.comman-tags, local.rg-tags)

  lifecycle {
    prevent_destroy = false # Prevent accidental deletion
    # ignore_changes = [ 
    #   tags, # Ignore changes to tags to avoid unnecessary updates
    # ]
  }
}