project_id  = "nathael-dev"
region      = "europe-west1"
environment = "dev"

topics = [
  "roles-created",
  "members-created",
  "member-roles-added",
  "member-roles-removed",
  "guild-created",
]

subscriptions = {
  "roles-created-guild" = {
    topic_name            = "roles-created"
    delivery_type         = "PULL"
    ack_deadline_seconds  = "60"
    retention_duration    = "604800s"
    message_ordering      = false
    exactly_once_delivery = false
    expiration_policy     = "31536000s"
  },
  "member-created-role" = {
    topic_name            = "members-created"
    delivery_type         = "PULL"
    ack_deadline_seconds  = "60"
    retention_duration    = "604800s"
    message_ordering      = false
    exactly_once_delivery = false
    expiration_policy     = "31536000s"
  },
  "member-roles-added-role" = {
    topic_name            = "member-roles-added"
    delivery_type         = "PULL"
    ack_deadline_seconds  = "60"
    retention_duration    = "604800s"
    message_ordering      = false
    exactly_once_delivery = false
    expiration_policy     = "31536000s"
  },
  "member-roles-removed-role" = {
    topic_name            = "member-roles-removed"
    delivery_type         = "PULL"
    ack_deadline_seconds  = "60"
    retention_duration    = "604800s"
    message_ordering      = false
    exactly_once_delivery = false
    expiration_policy     = "31536000s"
  },
  # "guild-created-member" = {
  #   topic_name            = "guilds-created"
  #   delivery_type         = "PULL"
  #   ack_deadline_seconds  = "60"
  #   retention_duration    = "604800s"
  #   message_ordering      = false
  #   exactly_once_delivery = false
  #   expiration_policy     = "31536000s"
  # },
}