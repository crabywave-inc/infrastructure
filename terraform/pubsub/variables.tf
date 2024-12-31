variable "project_id" {}
variable "region" {}

variable "environment" {}

variable "topics" {
  description = "A list of Pub/Sub topic names to create"
  type        = list(string)
}

variable "subscriptions" {
  description = "A map of Pub/Sub subscription configurations, with each key representing a subscription ID"
  type = map(object({
    topic_name            = string
    delivery_type         = string
    ack_deadline_seconds  = string
    retention_duration    = string
    message_ordering      = bool
    exactly_once_delivery = bool
    expiration_policy     = string
  }))
  default = {}
}
