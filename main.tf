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
  subnet_id           = module.network.subnet_containerapps_id
  MONGODB_URI         = module.cosmosDB.connection_string
}

module "cosmosDB" {
  source = "./modules/cosmosDB"

  resource_group_name = module.resourceGroup.name
  location            = module.resourceGroup.location
}

module "network" {
  source                  = "./modules/network"
  resource_group_name     = module.resourceGroup.name
  resource_group_location = module.resourceGroup.location
  cosmosdb_account_id     = module.cosmosDB.account_id
}

module "resourceGroup" {
  source = "./modules/resourceGroup"

}

module "backend" {
  source = "./modules/backend"

  rg_name  = module.resourceGroup.name
  location = module.resourceGroup.location
}

