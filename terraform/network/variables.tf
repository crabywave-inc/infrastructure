variable "project_id" {}
variable "region" {}

variable "environment" {}

variable "network_name" {
    description = "The name of the VPC network"
    type        = string
}

variable "subnets" {
    description = "The list of subnets"
    type = list(object({
        name          = string
        ip_cidr_range = string
    }))
}