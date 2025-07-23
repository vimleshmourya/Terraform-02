module "rg" {
  source = "./rg"
  rg-map = var.rg-map
}

module "vnet" {
  depends_on = [ module.rg ]
  source = "./vnet"
  vnet-map = var.vnet-map
}   

module "subnet" {
  depends_on = [ module.vnet ]
  source = "./subnet"
  subnet-map = var.subnet-map
}   

module "vm" {
  depends_on = [ module.subnet ]
  source = "./vm"
  vm-map = var.vm-map
}

module "datadisk" {
  depends_on = [ module.vm ]
  source = "./datadisk"
  data-disk-map = var.data-disk-map
}

module "datadiskattachment" {
  depends_on = [ module.datadisk ]
  source = "./datadiskattachment"
  data-disk-attachment-map = var.data-disk-attachment-map
}

module "nsg" {
  depends_on = [ module.subnet ]
  source = "./nsg"
  nsg-map = var.nsg-map
  
}

module "bastion" {
  depends_on = [ module.subnet ]
  source = "./bastion"
  bastion-map = var.bastion-map
}