resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "containerapps" {
  name                 = "subnet-containerapps"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/23"]
  
  delegation {
    name = "containerapp-delegation"
    service_delegation {
      name               = "Microsoft.App/environments"
    }
  }

}

resource "azurerm_subnet" "cosmosdb" {
  name                 = "subnet-cosmosdb"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_private_endpoint" "db_endpoint" {
  name                = "db_endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.cosmosdb.id

  private_service_connection {
    name                           = "db_connection"
    is_manual_connection           = false
    private_connection_resource_id = var.cosmosdb_account_id
    subresource_names              = ["mongodb"]
  }

}