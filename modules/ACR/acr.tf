resource "azurerm_container_registry" "acr" {
  name                = var.var_NAMEACR 
  resource_group_name = var.var_RGAKSNAME
  location            = var.var_LOCNAME
  sku                 = "Standard"
}

resource "azurerm_role_assignment" "acr_to_aks" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = var.var_PRINCIPALID
}
