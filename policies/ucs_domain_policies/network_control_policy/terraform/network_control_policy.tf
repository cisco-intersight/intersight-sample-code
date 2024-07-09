provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_eth_network_control_policy" "network_control_policy"{
    name = "eth_network_control_policy_1"
    description = "sample eth network control policy"
    organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }
    cdp_enabled = true
    forge_mac = "allow"
    lldp_settings {
        object_type = "fabric.LldpSettings"
        receive_enabled = true
        transmit_enabled = true
    }
    mac_registration_mode = "nativeVlanOnly"
    network_policy {
        object_type = "vnic.EthNetworkPolicy"
        moid = var.ethNetworkPolicy
    }
}

variable "ethNetworkPolicy"{
    type = string
    description = "Moid of Vnic.EthNetworkPolicy"
}