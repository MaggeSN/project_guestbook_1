resource "azurerm_storage_account" "backend_storage_account" {
  name                     = "gansketilfeldignavn13"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backend_storage_container" {
  name                  = "backendcontainer"
  storage_account_name  = azurerm_storage_account.backend_storage_account.name
  container_access_type = "private"
}
