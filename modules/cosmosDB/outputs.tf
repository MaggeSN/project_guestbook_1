output "account_id" {
  value = azurerm_mongo_cluster.cosmosdb_cluster.id
}

output "connection_string" {
  value = azurerm_mongo_cluster.cosmosdb_cluster.connection_strings[0]
}