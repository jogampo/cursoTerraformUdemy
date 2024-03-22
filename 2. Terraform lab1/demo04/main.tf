terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.94.0"
    }
  }
}

provider "azurerm"{
    features{}
}

resource "azurerm_resource_group" "rg_main"{
    location = var.location
    name = var.rg_name
}

module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  # insert the 3 required variables here
  resource_group_name = var.rg_name
  vnet_location = var.location
  use_for_each = false
  vnet_name = var.vnet_name
  address_space = [var.vnet_cirdr_range]
  subnet_prefixes = var.subnet_prefixes
  subnet_names = var.subnet_names
  tags = {
    enviroment = "dev"
  }
  depends_on = [azurerm_resource_group.rg_main]
}

