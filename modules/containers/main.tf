resource "azurerm_container_app_environment" "container_environment" {
  name                     = "container-environment"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  infrastructure_subnet_id = var.subnet_id
}

resource "azurerm_container_app" "backend_container" {
  name                         = "backend-app"
  container_app_environment_id = azurerm_container_app_environment.container_environment.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "backend"
      image  = "projectguestbook.azurecr.io/pg-backend:1.5.1"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "MONGODB_URI"
        value = var.DB_URI
      }

      env {
        name  = "AUTH_TOKEN"
        value = var.AUTH_TOKEN
      }
    }
  }
  ingress {
    external_enabled = true
    target_port      = 8080
    transport        = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

resource "azurerm_container_app" "frontend_container" {
  name                         = "frontend-app"
  container_app_environment_id = azurerm_container_app_environment.container_environment.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "frontend"
      image  = "projectguestbook.azurecr.io/pg-frontend:1.2.0"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "API_BASE_URL"
        value = var.API_BASE_URL
      }

      env {
        name  = "AUTH_TOKEN_FRONTEND"
        value = var.AUTH_TOKEN_FRONTEND
      }
    }
  }
  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}



