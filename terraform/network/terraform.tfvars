project_id  = "nathael-dev"
region      = "europe-west1"
environment = "dev"

network_name = "crabywave-vpc"
subnets = [
  {
    name          = "subnet-1"
    ip_cidr_range = "10.10.10.0/24"
  }
]