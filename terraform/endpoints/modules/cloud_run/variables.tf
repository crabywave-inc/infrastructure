variable "project_id" {
  description = "The GCP project ID where the Pub/Sub topics will be created"
  type        = string
}

variable "region" {
  description = "The GCP region where the subnet will be created"
  type        = string
}

variable "env" {
  description = "Environment label used by this Terraform deployment"
  type        = string
}


variable "image_uri" {
  description = "The URI of the container image to deploy"
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
  default     = 8000
}

variable "vpc_connector" {
  description = "The VPC connector to use for the Cloud Run service"
  type        = string
}
variable "secrets" {
  description = "List of secrets to be injected into the container"
  type        = map(string)
  default     = {}
}

variable "environment_variables" {
  description = "Environment variables for the Cloud Run service"
  type        = map(string)
  default     = {}
}

variable "service_account_roles" {
  description = "Roles to be assigned to the service account"
  type        = list(string)
  default     = []
}
