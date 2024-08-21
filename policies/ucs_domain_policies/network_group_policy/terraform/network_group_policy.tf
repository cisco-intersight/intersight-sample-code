provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_eth_network_group_policy" "eth_network_group_policy"{
    name = "fabric_ethNetork_group_policy_1"
    description = "sample fabric eth network group policy"
    organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }
    vlan_settings {
        object_type   = "fabric.VlanSettings"
        allowed_vlans = "14,313,315"
        native_vlan = 14
    }
}