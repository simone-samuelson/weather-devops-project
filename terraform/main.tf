terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group - logical container for Azure resources
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Development"
    Project     = "WeatherDashboard"
    ManagedBy   = "Terraform"
  }
}

# Container Registry - stores Docker images
resource "azurerm_container_registry" "acr" {
  name                = "weatherdashboardacr${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Environment = "Development"
    Project     = "WeatherDashboard"
  }
}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# Container Instance - runs the Docker container
resource "azurerm_container_group" "main" {
  name                = var.container_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  dns_name_label      = "weather-dashboard-${random_string.suffix.result}"

  image_registry_credential {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }

  container {
    name   = "weather-app"
    image  = var.docker_image
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 3000
      protocol = "TCP"
    }

    environment_variables = {
      PORT = "3000"
    }

    secure_environment_variables = {
      OPENWEATHER_API_KEY = var.openweather_api_key
    }
  }

  tags = {
    Environment = "Development"
    Project     = "WeatherDashboard"
  }
}