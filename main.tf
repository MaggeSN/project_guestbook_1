terraform {
  backend "azurerm" {
    resource_group_name  = "guestbook_rg_2"
    storage_account_name = "gansketilfeldignavn13"
    container_name       = "backendcontainer"
    key                  = "terraform.tfstate"
  }
  required_version = "~>1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "containers" {
  source = "./modules/containers"

  resource_group_name = module.resourceGroup.name
  location            = module.resourceGroup.location
}

module "cosmosDB" {
  source = "./modules/cosmosDB"

  resource_group_name = module.resourceGroup.name
  location            = module.resourceGroup.location
}

import {
  to = module.network.azurerm_virtual_network.vnet
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.Network/virtualNetworks/vnet_project_guestbook"
}
import {
  to = module.network.azurerm_subnet.containerapps
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.Network/virtualNetworks/vnet_project_guestbook/subnets/subnet-containerapps"
}
import {
  to = module.network.azurerm_subnet.cosmosdb
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.Network/virtualNetworks/vnet_project_guestbook/subnets/subnet-cosmosdb"
}

module "network" {
  source                  = "./modules/network"
  resource_group_name     = module.resourceGroup.name
  resource_group_location = module.resourceGroup.location
}

import {
  to = module.resourceGroup.azurerm_resource_group.rg
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2"
}

module "resourceGroup" {
  source = "./modules/resourceGroup"

}

module "backend" {
  source = "./modules/backend"

  rg_name  = module.resourceGroup.name
  location = module.resourceGroup.location
}

import {
  to = module.backend.azurerm_storage_account.backend_storage_account
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.Storage/storageAccounts/gansketilfeldignavn13"
}
import {
  to = module.backend.azurerm_storage_container.backend_storage_container
  id = "https://gansketilfeldignavn13.blob.core.windows.net/backendcontainer"
}
import {
  to = module.containers.azurerm_container_app.backend_container
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.App/containerApps/backend-app"
}
import {
  to = module.containers.azurerm_container_app_environment.container_environment
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.App/managedEnvironments/container-environment"
}
import {
  to = module.cosmosDB.azurerm_cosmosdb_account.db_account
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.DocumentDB/databaseAccounts/tfex-cosmos-db-account-1"
}
import {
  to = module.cosmosDB.azurerm_cosmosdb_mongo_database.db
  id = "/subscriptions/${var.SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.DocumentDB/databaseAccounts/tfex-cosmos-db-account-1/mongodbDatabases/projectguestbook_mongodb"
}