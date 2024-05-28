provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

 resource "intersight_vnic_eth_network_policy" "network_policy_1" {
  name            = "network_policy_1"
  target_platform = "Standalone"
  
  vlan_settings {
    default_vlan  = 1
    allowed_vlans = "11,12,13"
    mode          = "TRUNK"
  }

  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }