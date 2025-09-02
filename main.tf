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
  id = "/subscriptions/${secrets.ARM_SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2/providers/Microsoft.Network/virtualNetworks/vnet_project_guestbook"
}

module "network" {
  source                  = "./modules/network"
  resource_group_name     = module.resourceGroup.name
  resource_group_location = module.resourceGroup.location
}

import {
  to = module.resourceGroup.azurerm_resource_group.rg
  id = "/subscriptions/${secrets.ARM_SUBSCRIPTION_ID}/resourceGroups/guestbook_rg_2"
}

module "resourceGroup" {
  source = "./modules/resourceGroup"

}

module "backend" {
  source = "./modules/backend"

  rg_name  = module.resourceGroup.name
  location = module.resourceGroup.location
}