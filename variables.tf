variable "SUBSCRIPTION_ID" {
  description = "The Subscription ID where the resources will be created"
  type        = string
  sensitive   = true
}
variable "AUTH_TOKEN" {
  description = "The authentication token for the backend application."
  type        = string
  sensitive   = true

}
variable "MONGODB_DATABASE_NAME" {
  description = "The name of the MongoDB database to be created."
  type        = string
}
variable "MONGODB_DATABASE_COLLECTION_NAME" {
  description = "The name of the MongoDB collection to be created."
  type        = string
}