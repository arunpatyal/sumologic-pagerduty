#Sumo Logic - Pagerduty Terraform

variable "sumo_access_id" {}
variable "sumo_access_key" {}
variable "deployment" {}
variable "sumo_api_endpoint" {}
variable "collector_name" {
  default = "Pagerduty"
}

#Apps
variable "install_pagerduty" {}

#Source Categories
variable "pagerduty_sc" {}

# Pagerduty
variable pagerduty_api_endpoint {
  default = "https://api.pagerduty.com"
}
variable "pagerduty_api_key" {}
variable "pagerduty_services_pagerduty_webhooks" {}
variable "pagerduty_services_sumo_webhooks" {}
variable "install_sumo_to_pagerduty_webhook" {}