# Set up intersight environment
provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_vnic_fc_qos_policy" "v_fc_qos1" {
  name                = "v_fc_qos1"
  rate_limit          = 10000
  cos                 = 6
  max_data_field_size = 2112
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }