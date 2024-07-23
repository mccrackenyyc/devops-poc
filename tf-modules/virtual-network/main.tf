provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_prefixes)
  name                 = element(var.subnet_names, count.index)
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [element(var.subnet_prefixes, count.index)]
}

resource "azurerm_network_security_group" "nsg" {
  count               = length(var.subnet_names)
  name                = element(var.nsg_names, count.index)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count                     = length(var.subnet_names)
  subnet_id                 = element(azurerm_subnet.subnet.*.id, count.index)
  network_security_group_id = element(azurerm_network_security_group.nsg.*.id, count.index)
}

resource "azurerm_network_security_rule" "nsg_rules" {
  count                       = length(var.subnet_names) * length(var.nsg_rules)
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = element(azurerm_network_security_group.nsg.*.name, count.index / length(var.nsg_rules))
  name                        = element(var.nsg_rules[count.index % length(var.nsg_rules)]["name"], 0)
  priority                    = element(var.nsg_rules[count.index % length(var.nsg_rules)]["priority"], 0)
  direction                   = element(var.nsg_rules[count.index % length(var.nsg_rules)]["direction"], 0)
  access                      = element(var.nsg_rules[count.index % length(var.nsg_rules)]["access"], 0)
  protocol                    = element(var.nsg_rules[count.index % length(var.nsg_rules)]["protocol"], 0)
  source_port_range           = element(var.nsg_rules[count.index % length(var.nsg_rules)]["source_port_range"], 0)
  destination_port_range      = element(var.nsg_rules[count.index % length(var.nsg_rules)]["destination_port_range"], 0)
  source_address_prefix       = element(var.nsg_rules[count.index % length(var.nsg_rules)]["source_address_prefix"], 0)
  destination_address_prefix  = element(var.nsg_rules[count.index % length(var.nsg_rules)]["destination_address_prefix"], 0)
}