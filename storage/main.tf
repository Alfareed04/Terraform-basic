terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"           // Create a Resource Group using Terraform
}
 
provider "azurerm" {
    features {}
}
 
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.resource_group_location
}

resource "azurerm_storage_account" "stg" {
  name                     = "stc1209ytredm"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_storage_container" "container" {
    name = "containers"
    storage_account_name = azurerm_storage_account.stg.name
    container_access_type = "private"
    depends_on = [ azurerm_storage_account.stg ]
  
}

