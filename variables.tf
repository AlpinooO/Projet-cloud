variable "location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Nom du resource group"
  type        = string
  default     = "rg-mon-projet"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "mon-projet"
}

variable "vm_size" {
  description = "Taille de la VM"
  type        = string
  default     = "Standard_B1s"
}

variable "ssh_public_key_path" {
  description = "Chemin vers la clé SSH publique"
  type        = string
  default     = "C:/Users/agent/.ssh/id_rsa.pub"
}

variable "admin_username" {
  description = "Nom d'utilisateur admin"
  type        = string
  default     = "adminuser"
}

variable "storage_container_access" {
  description = "Niveau d'accès du container blob"
  type        = string
  default     = "blob"
}