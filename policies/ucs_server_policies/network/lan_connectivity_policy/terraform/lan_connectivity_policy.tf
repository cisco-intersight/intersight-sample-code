provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

data "intersight_vnic_eth_if" "eth_if_1" {
  name = "eth_if_1_name"   
}

data "intersight_vnic_eth_if" "eth_if_2" {
  name = "eth_if_2_name"  
}

resource "intersight_vnic_lan_connectivity_policy" "lan_connectivity_policy_1" {
  name                = "lan_connectivity_policy_1"
  iqn_allocation_type = "None"
  placement_mode      = "Custom"
  target_platform     = "Standalone"
  azure_qos_enabled   = false

  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }

  eth_ifs {
    object_type = "vnic.EthIf"
    moid        = data.intersight_vnic_eth_if.eth_if_1.moid
  }

  eth_ifs {
    object_type = "vnic.EthIf"
    moid        = data.intersight_vnic_eth_if.eth_if_2.moid
  }
}