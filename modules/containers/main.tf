resource "azurerm_container_app_environment" "container_environment" {
  name                       = "container-environment"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  infrastructure_subnet_id   = var.subnet_id
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

      env {
        name  = "MONGODB_URI"
        value = var.MONGODB_URI
      }

      /*env {
        name  = "AUTH_TOKEN"
        value = var.AUTH_TOKEN
      }*/

    }
  }
  ingress {
    external_enabled = false
    target_port      = 8080
    transport        = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}


