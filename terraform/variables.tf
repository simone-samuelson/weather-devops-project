variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "weather-dashboard-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "container_name" {
  description = "Name of the container instance"
  type        = string
  default     = "weather-dashboard"
}

variable "docker_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "openweather_api_key" {
  description = "OpenWeather API key"
  type        = string
  sensitive   = true
}