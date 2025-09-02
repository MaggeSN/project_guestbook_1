terraform {
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
module "network" {
  source                  = "./modules/network"
  resource_group_name     = module.resourceGroup.name
  resource_group_location = module.resourceGroup.location
}
module "resourceGroup" {
  source = "./modules/resourceGroup"
}
module "backend" {
  source = "./modules/backend"

  rg_name  = module.resourceGroup.name
  location = module.resourceGroup.location
}