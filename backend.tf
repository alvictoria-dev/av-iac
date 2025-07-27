terraform {
  backend "azurerm" {
    storage_account_name = "avtestterraform"
    container_name = "avtestterraform"
    key = "terraform.tfstate"
    resource_group_name  = "rg-terraform-state"
  }
}