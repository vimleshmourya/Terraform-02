rg-map = {
  rg1 = {
    name     = "vm-rg-01"
    location = "West Europe"
  }
  rg2 = {
    name     = "vnet-rg-01"
    location = "West Europe"
  }
}

vnet-map = {
  vnet1 = {
    name                = "vnet-01"
    location            = "West Europe"
    resource_group_name = "vnet-rg-01"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet-map = {
  subnet1 = {
    name                 = "backend-subnet-01"
    resource_group_name  = "vnet-rg-01"
    virtual_network_name = "vnet-01"
    address_prefix       = ["10.0.1.0/24"]
    location             = "West Europe"
  }
  subnet2 = {
    name                 = "frontend-subnet-01"
    resource_group_name  = "vnet-rg-01"
    virtual_network_name = "vnet-01"
    address_prefix       = ["10.0.2.0/24"]
    location             = "West Europe"
  }
  subnet3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "vnet-rg-01"
    virtual_network_name = "vnet-01"
    address_prefix       = ["10.0.3.0/24"]
    location             = "West Europe"
  }
}

nsg-map = {
  nsg1 = {
    subnet-name              = "backend-subnet-01"
    virtual_network_name     = "vnet-01"
    vnet_resource_group_name = "vnet-rg-01"
    location                 = "West Europe"
    securityrules = {
      rule1 = {
        name                       = "AllowSSH1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      rule2 = {
        name                       = "AllowHTTP"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
  nsg2 = {
    subnet-name              = "frontend-subnet-01"
    virtual_network_name     = "vnet-01"
    vnet_resource_group_name = "vnet-rg-01"
    location                 = "West Europe"
    securityrules = {
      rule1 = {
        name                       = "AllowSSH2"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}
vm-map = {
  vm1 = {
    vm-name                  = "backend-vm-01"
    location                 = "West Europe"
    vnet_resource_group_name = "vnet-rg-01"
    vm_resource_group_name   = "vm-rg-01"
    subnet-name              = "backend-subnet-01"
    virtual_network_name     = "vnet-01"
    os-disk = {
      osdisk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
      }
    }
    source-image-reference = {
      image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
  }

  vm2 = {
    vm-name                  = "frontend-vm-01"
    location                 = "West Europe"
    vnet_resource_group_name = "vnet-rg-01"
    vm_resource_group_name   = "vm-rg-01"
    resource_group_name      = "vm-rg-01"
    subnet-name              = "frontend-subnet-01"
    virtual_network_name     = "vnet-01"
    os-disk = {
      osdisk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
      }
    }
    source-image-reference = {
      image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
  }
}

data-disk-map = {
  disk1 = {
    disk-name              = "backend-vm-01-disk-01"
    location               = "West Europe"
    vm_resource_group_name = "vm-rg-01"
    storage_account_type   = "Standard_LRS"
    disk_size_gb           = 10
  }
  disk2 = {
    disk-name              = "backend-vm-01-disk-02"
    location               = "West Europe"
    vm_resource_group_name = "vm-rg-01"
    storage_account_type   = "Standard_LRS"
    disk_size_gb           = 10
  }
  disk3 = {
    disk-name              = "frontend-vm-01-disk-01"
    location               = "West Europe"
    vm_resource_group_name = "vm-rg-01"
    storage_account_type   = "Standard_LRS"
    disk_size_gb           = 128
  }
}

data-disk-attachment-map = {
  attachment1 = {
    vm-name                = "backend-vm-01"
    managed-disk-name      = "backend-vm-01-disk-01"
    vm_resource_group_name = "vm-rg-01"
    lun                    = "0"
  }
  attachment2 = {
    vm-name                = "backend-vm-01"
    managed-disk-name      = "backend-vm-01-disk-02"
    vm_resource_group_name = "vm-rg-01"
    lun                    = "1"
  }
  attachment3 = {
    vm-name                = "frontend-vm-01"
    managed-disk-name      = "frontend-vm-01-disk-01"
    vm_resource_group_name = "vm-rg-01"
    lun                    = "0"
  }
}

bastion-map = {
  bastion1 = {
    subnet-name              = "AzureBastionSubnet"
    virtual_network_name     = "vnet-01"
    vnet_resource_group_name = "vnet-rg-01"
    location                 = "West Europe"
    bastion-name             = "bastion-host-01"
    ip-configuration = {
      config1 = {
        name = "bastion-ip-config-01"
      }
    }
  }
}
