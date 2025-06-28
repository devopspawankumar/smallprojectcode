variable "key_vault_name" {
  type        = string
  description = "Key Vault ka Naam"
  default     = "rajakitijori"
}
variable "location" {
  description = "The Azure region where the Key Vault will be created."
  type        = string

  
}
variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created."
  type        = string
}

data "azurerm_client_config" "current" {}


variable "secret_name" {
  description = "The name of the secret."
  type        = string
}

variable "secret_value" {
  description = "The value of the secret."
  type        = string
  sensitive   = true
}
