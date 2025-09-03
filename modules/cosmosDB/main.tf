resource "azurerm_cosmosdb_account" "db_account" {
  name                = "tfex-cosmos-db-account-1"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "MongoDB"

  automatic_failover_enabled = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = "eastus"
    failover_priority = 1
  }

  geo_location {
    location          = "westus"
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

