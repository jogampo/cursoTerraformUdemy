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
    alias = "pruebaLocal"
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
}
