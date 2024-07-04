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

resource "azurerm_virtual_network" "vnet" {
  name = var.virtual_network_name
  address_space = var.virtual_network_address_space
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

resource "azurerm_subnet" "subnet" {
  name = var.subnet_name
  address_prefixes = var.subnet_address_prefix
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

