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