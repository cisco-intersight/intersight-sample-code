provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_fabric_eth_network_group_policy" "fabric_eth_network_group_policy1" {
  name        = "fabric_eth_network_group_policy1"
  description = "demo eth network group policy"
  vlan_settings {
    native_vlan   = 1
    allowed_vlans = "313,314,1000"
    object_type   = "fabric.VlanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

variable "organization" {
    type = string
    description = "<organization moid>"
}