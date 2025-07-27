resource "azurerm_virtual_network" "virtual-network-default" {
  name                = var.var_NETNAME # "Vnet where you are going to create subnet of AKS"
  address_space       = var.var_ADDSPACE
  location            = var.var_LOCNAME
  resource_group_name = var.var_RGAKSNAME
}

resource "azurerm_subnet" "subnet-aks-nodes" {
  name                 = var.var_SUBNETAKSNAME
  resource_group_name  = var.var_RGAKSNAME
  virtual_network_name = azurerm_virtual_network.virtual-network-default.name
  address_prefixes     = var.var_SUBNETAKS
}