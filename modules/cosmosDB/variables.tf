variable "resource_group_name" {
  description = "The name of the resource group in which to create the container instance."
  type        = string

}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "MONGODB_DATABASE_NAME" {
  description = "The name of the MongoDB database to be created."
  type        = string
}

variable "MONGODB_DATABASE_COLLECTION" {
  description = "The name of the MongoDB collection to be created."
  type        = string
}