resource "azurerm_container_app_environment" "container_environment" {
  name                       = "container-environment"
  resource_group_name        = var.resource_group_name
  location                   = var.location
}

resource "azurerm_container_app" "backend_container" {
  name                         = "backend-app"
  container_app_environment_id = azurerm_container_app_environment.container_environment.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "backend"
      image  = "projectguestbook.azurecr.io/pg-backend:1.3"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}

