variable "resource_group_name" {
    type = string
    default = "fareedrg"
}

variable "resource_group_location" {
    type = string
    default = "East US"
}

variable "virtual_network_name" {
  type    = string
  default = "vnet01"  // Default virtual network name
}

variable "virtual_network_address_space" {
    type = list(string)
    default = [ "10.0.0.0/16" ]
}

variable "subnet_name" {
    type =string
    default = "sub01"
}

variable "subnet_address_prefix" {
    type = list(string)
    default = [ "10.0.1.0/24" ]
}