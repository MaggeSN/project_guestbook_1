variable "rg_name" {
    description = "The name of the resource group."
    type        = string
}
variable "location" {
    description = "The location of the rg."
    type        = string
    default     = "US East"
}
