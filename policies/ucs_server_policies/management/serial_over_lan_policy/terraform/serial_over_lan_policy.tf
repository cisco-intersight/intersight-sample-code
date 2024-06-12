provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_sol_policy" "sol1" {
  name        = "sample_sol_policy"
  description = "demo serial over lan policy"
  enabled     = false
  baud_rate   = 9600
  com_port    = "com1"
  ssh_port    = 2120
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }