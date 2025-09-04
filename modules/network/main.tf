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
  private_endpoint_network_policies = "Enabled"
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
  private_dns_zone_group {
    name                 = "db_dns_zone_group"
    private_dns_zone_ids = [azurerm_private_dns_zone.cosmosdb.id]
  }

}
resource "azurerm_private_dns_zone" "cosmosdb" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmosdb_link" {
  name                  = "cosmosdb-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.cosmosdb.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}