resource "azurerm_virtual_network" "vnet" {
  name                = "demoLab-vnet"
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = var.vnet_name
    address_prefix = "10.0.1.0/24"
  }

  tags = {
    environment = "Production"
  }
}