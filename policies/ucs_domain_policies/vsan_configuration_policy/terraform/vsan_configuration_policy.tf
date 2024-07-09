provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy1" {
  name            = "fabric_fc_network_policy1"
  description     = "fabric ethernet network policy"
  enable_trunking = true
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

resource "intersight_fabric_vsan" "vsan_110" {
  name             = "vsan_110"
  default_zoning   = "Disabled"
  vsan_scope       = "Uplink"
  fcoe_vlan        = 1120
  vsan_id          = 110
  fc_network_policy {
    object_type = "fabric.FcNetworkPolicy"
    moid        = intersight_fabric_fc_network_policy.fabric_fc_network_policy1.moid
  }
}