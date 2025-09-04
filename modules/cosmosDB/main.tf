resource "azurerm_mongo_cluster" "cluster" {
  name                   = "cluster12346978420"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_username = "adminTerraform"
  administrator_password = "passord123!"
  shard_count            = "1"
  compute_tier           = "Free"
  high_availability_mode = "Disabled"
  storage_size_in_gb     = "32"
  version                = "8.0"
}