output "rg_name" {
  value       = module.resourceGroup.name
  description = "Name of the resource group"
}
output "location" {
  value       = module.resourceGroup.location
  description = "Location of the resource group"
}
