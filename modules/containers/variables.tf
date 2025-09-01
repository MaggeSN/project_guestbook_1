variable "resource_group_name" {
    description = "The name of the resource group in which to create the container app environment and container app."
    type        = string
}

variable "location" {
    description = "The Azure region where the resources will be created."
    type        = string
    default    = "East US"
}

variable "log_analytics_workspace_id" {
    description = "The ID of the Log Analytics Workspace to associate with the container app environment."
    type        = string
}

