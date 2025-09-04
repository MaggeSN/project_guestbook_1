resource "azurerm_mongo_cluster" "cosmosdb_cluster" {
  name                   = "cosmosdb_cluster"
  resource_group_name    = var.resource_group_name
  location               = var.location
  mongo_version         = "8.0"
  administrator_username = "adminTerraform"
  administrator_password = "passord123!"
  shard_count            = "1"
  compute_tier           = "Free"
  high_availability_mode = "Disabled"
  storage_size_in_gb     = "10"
}

resource "azurerm_mongodb_database" "db" {
  name                = var.MONGODB_DATABASE_NAME
  resource_group_name = var.resource_group_name
  cluster_id         = azurerm_mongodb_cluster.cluster.id
}

resource "azurerm_mongodb_collection" "collection" {
  name                = var.MONGODB_DATABASE_COLLECTION_NAME
  resource_group_name = var.resource_group_name
  database_id        = azurerm_mongodb_database.db.id
  
  index {
    key    = "_id"
    unique = true
  }
}