variable "resource_group_name" {
    description = "The name of the resource group in which to create the container app environment and container app."
    type        = string
}

variable "location" {
    description = "The Azure region where the resources will be created."
    type        = string
    default    = "East US"
}

variable "MONGODB_URI" {
    description = "The connection string for the Cosmos DB instance."
    type        = string
    sensitive   = true

}
/*variable "AUTH_TOKEN" {
    description = "The authentication token for the backend application."
    type        = string
    sensitive   = true
  
}*/
variable "subnet_id" {
    description = "The ID of the subnet to deploy the container app environment into."
    type        = string
}