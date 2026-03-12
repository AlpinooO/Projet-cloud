output "vm_public_ip" {
  description = "IP publique de la VM"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "vm_name" {
  description = "Nom de la VM"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "resource_group_name" {
  description = "Nom du resource group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Nom du storage account"
  value       = azurerm_storage_account.storage.name
}

output "blob_endpoint" {
  description = "Endpoint public du Blob Storage"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "app_url" {
  description = "URL de l'application backend"
  value       = "http://${azurerm_public_ip.public_ip.ip_address}:8080"
}

output "ssh_command" {
  description = "Commande SSH pour se connecter"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
}