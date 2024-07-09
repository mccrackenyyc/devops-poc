resource "azurerm_resource_group" "rg_network" {
  name     = "${var.project}-${var.env}-${var.location}-rg-network"
  location = var.location
}