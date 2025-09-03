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
variable "COSMOSDB_CONNECTION" {
  description = "The connection string for the Cosmos DB instance."
  type        = string
  sensitive   = true
}