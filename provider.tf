terraform {
    # backend "azurerm" {
    # resource_group_name  = "Amit-rg"
    # storage_account_name = "devenvrionment12"
    # container_name       = "tfstate"
    # key                  = "ranjeet.terraform.tfstate"
    # key                  = "${terraform.workspace}.terraform.tfstate"
  # }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
