locals {
  subnet_names =[for i in azurerm_subnet.subnet : i.name]
  nsg_names = [for i in azurerm_network_security_group.nsg : i.name]
  subnet_id = [for i in azurerm_subnet.subnet : i.id]
}