module "rgmod" {
    source = "../../Child_Module/Azurerm_Resource_Group"
    rgs = var.rg_dev
}

module "netmod" {
    depends_on = [ module.rgmod ]
    source = "../../Child_Module/Azurerm_Networking"
    vnet = var.net_dev
}

module "pipmod" {
    depends_on = [ module.rgmod ]
    source = "../../Child_Module/Azurerm_Public-ip"
    pip = var.pip_dev
}

module "nsgmod" {
    depends_on = [ module.rgmod ]
    source = "../../Child_Module/Azurerm_NSG"
    nsg = var.nsg_dev
}

module "vmmod" {
    depends_on = [ module.netmod ]
    source = "../../Child_Module/Azurerm_Compute"
    vms = var.vm_dev
}

module "mssqlservermod" {
    depends_on = [ module.rgmod ]
    source = "../../Child_Module/Azurerm_MySQL_Server"
    mssql_server = var.mssql_server_dev
}

module "mssqldbmod" {
    depends_on = [ module.rgmod, module.mssqlservermod ]
  source = "../../Child_Module/Azurerm_MySQL_Database"
  mssql_db = var.mssql_db_dev
}

module "baistianmod" {
    depends_on = [ module.rgmod, module.netmod, module.pipmod ]
    source = "../../Child_Module/Azurerm_Bastion"
    jump-host = var.bastion_dev

}
  
