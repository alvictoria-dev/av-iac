module "Create-RGs" {
    source = "./modules/ResourceGroup"
    var_RGAKSNAME = var.var_RGAKSNAME
    var_RGNETNAME = var.var_RGNETNAME
    var_LOCNAME = var.var_LOCNAME
}

module "Create-Net" {
    source = "./modules/Network"
    var_RGAKSNAME = var.var_RGNETNAME
    var_LOCNAME = var.var_LOCNAME
    var_NETNAME = var.var_NETNAME
    var_ADDSPACE = var.var_ADDSPACE
    var_SUBNETAKSNAME = var.var_SUBNETAKSNAME
    var_SUBNETAKS = var.var_SUBNETAKS
    depends_on = [module.Create-RGs]
}

module "Create-AKS" {
    source = "./modules/AKS"
    var_LOCNAME            = var.var_LOCNAME
    var_NAMEAKS            = var.var_NAMEAKS
    var_RGAKSNAME          = var.var_RGAKSNAME
    var_subnet_id          = module.Create-Net.subnet-aks-id
    depends_on = [module.Create-Net]
}

module "Create-ACR" {
    source = "./modules/ACR"
    var_LOCNAME            = var.var_LOCNAME
    var_NAMEACR            = var.var_NAMEACR
    var_RGAKSNAME          = var.var_RGAKSNAME
    var_PRINCIPALID        = module.Create-AKS.ara_principal_id
    depends_on = [module.Create-AKS]
}