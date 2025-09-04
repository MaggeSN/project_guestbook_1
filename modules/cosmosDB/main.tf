resource "azurerm_mongo_cluster" "cluster" {
  name                   = "cosmosdb_cluster"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_username = "adminTerraform"
  administrator_password = "passord123!"
  shard_count            = "1"
  compute_tier           = "Free"
  high_availability_mode = "Disabled"
  storage_size_in_gb     = "32"
}