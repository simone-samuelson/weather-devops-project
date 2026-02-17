output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "container_registry_login_server" {
  description = "Login server for the container registry"
  value       = azurerm_container_registry.acr.login_server
}

output "container_registry_username" {
  description = "Admin username for container registry"
  value       = azurerm_container_registry.acr.admin_username
  sensitive   = true
}

output "application_url" {
  description = "URL to access the weather dashboard"
  value       = "http://${azurerm_container_group.main.fqdn}:3000"
}

output "container_ipv4_address" {
  description = "Public IP address of the container"
  value       = azurerm_container_group.main.ip_address
}