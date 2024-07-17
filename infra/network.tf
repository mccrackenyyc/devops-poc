resource "azurerm_resource_group" "rg_network" {
  name     = "${var.project}-${var.env}-${var.loc_short}-rg-network"
  location = var.location
}

resource "azurerm_virtual_network" "vnet_main" {
  name                = "${var.project}-${var.env}-${var.loc_short}-vnet"
  location            = azurerm_resource_group.rg_network.location
  resource_group_name = azurerm_resource_group.rg_network.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "${var.env}-snet-psqldb"
    address_prefix = "10.0.1.0/24"
  }
}