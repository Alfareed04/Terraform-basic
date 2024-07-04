variable "resource_group_name" {
  type = string
  default = "fareed"
}

variable "resource_group_location" {
  type = string
  default = "East US"
}

variable "virtual_network_name" {
    type = string
    default = "vnet01"
}

variable "virtual_network_address_space" {
    type = list(string)
    default = [ "10.0.0.0/16" ]
}

variable "subnet_details" {
    type = map(object({
      name = string
      address_prefix = string
    }))
    default = {
      "subnet1" = {
        name = "subnet1"
        address_prefix = "10.0.1.0/24"    //subnet1-nsg subnet-nsg
      },
      "subnet2" = {
        name = "subnet2"
        address_prefix = "10.0.2.0/24"   
      },
      "subnet3" = {
        name = "subnet3"
        address_prefix = "10.0.3.0/24"   
      }

    }
  
}