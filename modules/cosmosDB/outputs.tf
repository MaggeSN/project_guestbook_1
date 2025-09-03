output "connection_string" {
  value = azurerm_cosmosdb_account.db_account.connection_strings[0]
}

output "account_id" {
  value = azurerm_cosmosdb_account.db_account.id
}
