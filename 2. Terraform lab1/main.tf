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

resource "azurerm_resource_group" "rgdemoLabCursoUdemy" {
  name     = var.rg_name
  location = var.rg_location
  }


resource "azurerm_virtual_network" "vnet" {
  name                = "demoLab-vnet"
  location            = azurerm_resource_group.rgdemoLabCursoUdemy.location
  resource_group_name = azurerm_resource_group.rgdemoLabCursoUdemy.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  tags = {
    environment = "Production"
  }
}