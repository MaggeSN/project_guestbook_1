resource "azurerm_cosmosdb_account" "db_account" {
  name                = "tfex-cosmos-db-account-1"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "MongoDB"

  automatic_failover_enabled = true

  capabilities {
    name = "EnableMongo"
  }
  
  capabilities {
    name = "MongoDBEnableVCore"  // Aktiverer vCore
  }

  public_network_access_enabled = false
  is_virtual_network_filter_enabled = true
  ip_range_filter = ""

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = "eastus"
    failover_priority = 0
  }

}

resource "azurerm_cosmosdb_mongo_database" "db" {
  name                = "projectguestbook_mongodb"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.db_account.name
}

resource "azurerm_cosmosdb_mongo_collection" "collection" {
  name                = "guestbook_collection"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.db_account.name
  database_name       = azurerm_cosmosdb_mongo_database.db.name
  index {
    keys = ["_id"]
    unique = true
  }
}

