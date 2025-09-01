variable "resource_group_name" {
  type    = string
  default = "project_guestbook"
}

variable "resource_group_location" {
  type    = string
  default = "US East"
}

variable "vnet_name" {
  type    = string
  default = "vnet_project_guestbook"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}