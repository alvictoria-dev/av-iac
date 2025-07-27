resource "azurerm_resource_group" "rg-aks-name" {
  name = var.var_RGAKSNAME
  location = var.var_LOCNAME
}

resource "azurerm_resource_group" "rg-net-name" {
  name = var.var_RGNETNAME
  location = var.var_LOCNAME
}