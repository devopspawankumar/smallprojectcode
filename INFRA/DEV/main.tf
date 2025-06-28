module "resource_group" {
  source                   = "../../MODULES/AZURERM_RESOURCE_GROUP"
  resource_group_name      = "rg_dev"
  resource_group_location  = "japanwest"
}
module "virtual_network" {
    depends_on = [module.resource_group]
  source                          = "../../MODULES/AZURERM_VIRTUAL_NETWORK"
  virtual_network_name            = "vnet_dev"
  virtual_network_address_space   = ["10.0.0.0/16"]
  resource_group_name             = "rg_dev"
  resource_group_location         = "japanwest"
}
module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source              = "../../MODULES/AZURERM_SUBNET"
  subnet_name         = "subnet_dev"
  address_prefixes    = ["10.0.1.0/24"] 
    virtual_network_name = "vnet_dev"
    resource_group_name = "rg_dev"
}
module "backend_subnet" {
    depends_on = [module.virtual_network]
  source              = "../../MODULES/AZURERM_SUBNET"
  subnet_name         = "subnet_dev"
  address_prefixes    = ["10.0.2.0/24"] 
    virtual_network_name = "vnet_dev"
    resource_group_name = "rg_dev"
}
module "frontend_pip" {
    depends_on = [module.resource_group]
  source                    = "../../MODULES/AZURERM_PUBLIC_IP"
  public_ip_name            = "pip_dev"
  resource_group_name       = "rg_dev"
  resource_group_location   = "japanwest"
  allocation_method         = "Dynamic"
}

module "kv" {
    depends_on = [ module.resource_group ]
    source              = "../../MODULES/AZURERM_KEY_VAULT"
    key_vault_name      = "kvpaawandev"
    resource_group_name = "rg_dev"
    location            = "japanwest"
    secret_name         = "dbPassword"
    secret_value        = "P@ssw0rd1234!"
}
module "kv_secret" {
  source              = "../../MODULES/aZURERM_KEY_VAULT"
  key_vault_name      = "kvpaawandev"
  secret_name         = "dbPassword"
  secret_value        = "P@ssw0rd1234!"
  resource_group_name = "rg_dev"
  location            = "japanwest"
  depends_on = [module.kv, module.resource_group]
}
module "sql_server" {
    depends_on = [module.resource_group]
  source              = "../../MODULES/AZURERM_SQL_SERVER"
  sql_server_name     = "sqlpawanserverdev"
  resource_group_name = "rg_dev"
  location            = "japanwest"
  administrator_login = "sqladmin"
  administrator_login_password = "P@ssw0rd1234!"
 
}
module "sql_database" {
    depends_on = [module.sql_server]
  source              = "../../MODULES/AZURERM_SQL_DATABASE"
  sql_database_name   = "pawan_db_dev"
  resource_group_name = "rg_dev"

  sql_server_name     = "sqlpawanserverdev"

}

module "backend_vm" {
  depends_on = [module.frontend_subnet, module.resource_group, module.kv, module.sql_server, module.sql_database]
  source                   = "../../MODULES/AZURERM_VIRTUAL_MACHINE"
  vm_name                  = "vmdev"
  resource_group_name      = "rg_dev"
  resource_group_location  = "japanwest"
  vm_size                  = "Standard_B1s"
  vm_admin_username        = "azureuser"
  vm_admin_password        = "P@ssw0rd1234!"
  nic_name                 = "nicdev"
  os_disk_name             = "osdisk-vmdev"
  os_disk_caching          = "ReadWrite"
  os_disk_size_gb          = 30
    subnet_name              = "subnet_dev"
    virtual_network_name     = "vnet_dev"
    address_prefixes         = ["10.0.1.0/24"]
    public_ip_name           = "pip_dev"
}

