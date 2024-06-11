provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_server_profile" "server1" {
  name   = "server1"
  action = "No-op"
  tags {
    key   = "server"
    value = "demo"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_vnic_san_connectivity_policy" "vnic_san1" {
  name = "san_connectivity_policy_1"
  placement_mode  = "custom"
  target_platform = "Standalone"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  profiles {
    moid        = intersight_server_profile.server1.moid
    object_type = "server.Profile"
  }
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }