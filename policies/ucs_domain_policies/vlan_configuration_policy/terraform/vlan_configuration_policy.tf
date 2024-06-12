provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_fabric_eth_network_policy" "fabric_eth_network_policy1" {
  name        = "fabric_eth_network_policy1"
  description = "fabric ethernet network policy"
  organization {
    object_type = "organization.Organization"
    moid = var.organization
  }
}

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy1" {
  name             = "fabricMultiCastPolicy"
  querier_state    = "Enabled"
  snooping_state   = "Enabled"
  querier_ip_address = "11.11.11.11"
  organization {
    object_type = "organization.Organization"
    moid = var.organization
  }
}


resource "intersight_fabric_vlan" "fabric_vlan1" {
  auto_allow_on_uplinks = true
  is_native             = false
  name                  = "fabric_vlan1"
  vlan_id               = 23
  
  eth_network_policy {
    moid        = intersight_fabric_eth_network_policy.fabric_eth_network_policy1.moid
    object_type = "fabric.EthNetworkPolicy"
  }

  multicast_policy {
    object_type = "fabric.MulticastPolicy"
    moid        = intersight_fabric_multicast_policy.fabric_multicast_policy1.moid
  } 
}

variable "organization" {
  type = string
  description = "<organization moid>"
}
