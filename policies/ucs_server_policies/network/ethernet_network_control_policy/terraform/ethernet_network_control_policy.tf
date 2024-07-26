provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_eth_network_control_policy" "fabric_eth_network_control_policy1" {
  name        = "eth_network_control_policy_1"
  description = "eth network control policy"
  cdp_enabled = false
  forge_mac   = "allow"
  lldp_settings {
    class_id         = "fabric.LldpSettings"
    object_type      = "fabric.LldpSettings"
    receive_enabled  = false
    transmit_enabled = false
  }
  mac_registration_mode = "allVlans"
  uplink_fail_action    = "linkDown"
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}