output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.example.id
}

output "subnet_ids" {
  description = "The IDs of the Subnets"
  value       = azurerm_subnet.example[*].id
}
