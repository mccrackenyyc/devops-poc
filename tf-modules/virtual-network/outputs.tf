output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "The IDs of the Subnets"
  value       = azurerm_subnet.subnet[*].id
}

output "nsg_ids" {
  description = "The IDs of the Network Security Groups"
  value       = azurerm_network_security_group.nsg[*].id
}