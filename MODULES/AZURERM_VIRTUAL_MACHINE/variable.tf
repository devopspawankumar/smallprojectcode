variable "resource_group_name" {
  description = "The name of the resource group where the VM will be created."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface."
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "vm_admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "vm_admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
}

variable "os_disk_name" {
  description = "The name of the OS disk."
  type        = string
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB."
  type        = number
}

variable "os_disk_caching" {
  description = "The caching type for the OS disk."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes for the virtual network."
  type        = list(string)
  default     = []
}
variable "public_ip_name" {
  description = "The name of the public IP address."
  type        = string
}