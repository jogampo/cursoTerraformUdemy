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


module "vnet"{
    source = "./modules/az_networking"
    rg_location = azurerm_resource_group.rgdemoLabCursoUdemy.location
    rg_name = azurerm_resource_group.rgdemoLabCursoUdemy.name
}


