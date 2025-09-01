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

    resource_group_name        = module.resourceGroup.name
    location                   = module.resourceGroup.location
    log_analytics_workspace_id = module.network.log_analytics_workspace_id
}
module "cosmosDB" {
    source = "./modules/cosmosDB"
}
module "network" {
    source = "./modules/network"
}
module "resourceGroup" {
    source = "./modules/resourceGroup"
}