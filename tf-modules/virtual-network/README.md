# Azure Virtual Network Module

This module creates an Azure Virtual Network with subnets and an optional Network Security Group.

## Usage

```hcl
module "vnet" {
  source              = "../terraform-azure-vnet"
  resource_group_name = "example-rg"
  location            = "East US"
  vnet_name           = "example-vnet"
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

## Inputs

| Name               | Description                            | Type          | Default | Required |
|--------------------|----------------------------------------|---------------|---------|----------|
| resource_group_name| The name of the resource group         | string        | n/a     | yes      |
| location           | The Azure region                       | string        | n/a     | yes      |
| vnet_name          | The name of the virtual network        | string        | n/a     | yes      |
| address_space      | The address space for the VNet         | list(string)  | n/a     | yes      |
| subnet_names       | The names of the subnets               | list(string)  | n/a     | yes      |
| subnet_prefixes    | The address prefixes for the subnets   | list(string)  | n/a     | yes      |
| nsg_names          | The names of the Network Security Groups| list(string)  | n/a     | yes      |
| nsg_rules          | The security rules for the NSGs        | list(object)  | []      | no       |

## Outputs

| Name    | Description                           |
|---------|---------------------------------------|
| vnet_id | The ID of the Virtual Network         |
| subnet_ids | The IDs of the Subnets             |
| nsg_ids | The IDs of the Network Security Groups|
