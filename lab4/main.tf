resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.resource_group_location
}

resource "azurerm_virtual_network" "vnet" {
    name = var.virtual_network_name
    address_space = var.virtual_network_address_space
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnet_details
  name = each.value.name
  address_prefixes = [each.value.address_prefix]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [ azurerm_resource_group.rg , azurerm_virtual_network.vnet ]
}

# NSG
resource "azurerm_network_security_group" "nsg" {
  for_each = toset([for i in azurerm_subnet.subnet : i.name])
  name = "${each.key}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  depends_on = [ azurerm_subnet.subnet]
}

resource "azurerm_subnet_network_security_group_association" "nsgass" {
  for_each = {for id, nsg in azurerm_network_security_group.nsg : id => nsg.id}

  network_security_group_id = each.value
  subnet_id = azurerm_subnet.subnet[each.key].id
  depends_on = [ azurerm_subnet.subnet, azurerm_network_security_group.nsg ]
}
resource "azurerm_network_interface" "nic" {
  for_each = toset(local.subnet_names)
  name = "${each.key}-nic"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet[each.key].id
    //subnet_id = [for i in azurerm_subnet.subnet[each.key] : i.id]
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ azurerm_subnet.subnet ]
}