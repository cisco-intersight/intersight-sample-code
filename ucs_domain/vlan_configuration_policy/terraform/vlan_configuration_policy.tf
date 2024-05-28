provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_fabric_vlan" "fabric_vlan1" {
  auto_allow_on_uplinks = true
  is_native             = true
  name                  = "fabric_vlan1"
  vlan_id               = 10
  eth_network_policy {
    moid        = var.vnic_eth_network
    object_type = "fabric.EthNetworkPolicy"
  }
  multicast_policy {
    moid        = var.fabric_multicast_policy
    object_type = "fabric.MulticastPolicy"
  }
}

variable "vnic_eth_network" {
  type        = string
  description = "Moid of vnic_eth_network"
}

variable "fabric_multicast_policy" {
  type        = string
  description = "Moid of fabric_multicast_policy"
}