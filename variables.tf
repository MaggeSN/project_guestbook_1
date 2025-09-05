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

variable "API_BASE_URL" {
  description = "The base URL for the frontend application."
  type        = string
  
}

variable "AUTH_TOKEN_FRONTEND" {
  description = "The authentication token for the frontend application."
  type        = string
  sensitive   = true

}