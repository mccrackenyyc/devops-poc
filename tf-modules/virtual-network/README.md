# Azure Virtual Network Module

This module creates an Azure Virtual Network with subnets.

## Usage

```hcl
module "vnet" {
  source              = "../tf-modules/terraform-azure-vnet"
  resource_group_name = "example-rg"
  location            = "East US"
  vnet_name           = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_names        = ["subnet1", "subnet2"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
}
