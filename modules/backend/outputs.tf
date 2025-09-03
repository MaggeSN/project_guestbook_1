output "storage_account_name" {
  value       = azurerm_storage_account.backend_storage_account.name
  description = "Name of the storage account"
}
output "container_name" {
  value       = azurerm_storage_container.backend_storage_container.name
  description = "Name of the storage container"
}