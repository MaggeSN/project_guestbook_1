output "subnet_containerapps_id" {
  description = "ID for subnettet som brukes av Container Apps"
  value       = azurerm_subnet.containerapps.id
}

output "subnet_cosmosdb_id" {
  description = "ID for subnettet som brukes av Cosmos DB Private Endpoint"
  value       = azurerm_subnet.cosmosdb.id
}