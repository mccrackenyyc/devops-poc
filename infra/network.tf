# resource "azurerm_resource_group" "rg_network" {
#   name     = "${var.project}-${var.env}-${var.loc_short}-rg-network"
#   location = var.location
# }

# resource "azurerm_virtual_network" "vnet_main" {
#   name                = "${var.project}-${var.env}-${var.loc_short}-vnet"
#   location            = azurerm_resource_group.rg_network.location
#   resource_group_name = azurerm_resource_group.rg_network.name
#   address_space       = ["10.0.0.0/16"]

#   subnet {
#     name           = "${var.env}-snet-psqldb"
#     address_prefix = "10.0.1.0/24"
#   }
# }

module "vnet" {
  source              = "../tf-modules/virtual-network"
  resource_group_name = "${local.name_prefix}-rg-network"
  location            = var.location
  vnet_name           = "${local.name_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_names        = ["subnet1", "subnet2"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  nsg_names           = ["nsg-subnet1", "nsg-subnet2"]
  nsg_rules = [
    {
      name                      = "allow_ssh"
      priority                  = 100
      direction                 = "Inbound"
      access                    = "Allow"
      protocol                  = "Tcp"
      source_port_range         = "*"
      destination_port_range    = "22"
      source_address_prefix     = "*"
      destination_address_prefix= "*"
    },
    {
      name                      = "allow_http"
      priority                  = 200
      direction                 = "Inbound"
      access                    = "Allow"
      protocol                  = "Tcp"
      source_port_range         = "*"
      destination_port_range    = "80"
      source_address_prefix     = "*"
      destination_address_prefix= "*"
    }
  ]
}