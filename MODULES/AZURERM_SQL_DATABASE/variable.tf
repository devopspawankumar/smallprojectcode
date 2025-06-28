

variable "sql_database_name" {}

variable "sql_server_name" {
  description = "The name of the Azure SQL Server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group containing the SQL Server."
  type        = string
}
