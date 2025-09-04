output "account_id" {
  value = azurerm_mongo_cluster.cluster.id
}

output "connection_string" {
  value = azurerm_mongo_cluster.cluster.connection_strings[0].value
}