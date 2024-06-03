resource "intersight_fabric_eth_network_control_policy" "network_control_policy"{
    name = "eth_network_control_policy_1"
    description = "sample eth network control policy"
    organization  {
        object_type = "organization.Organization"
        moid = var.organization
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

variable "organization"{
    type = string
    description = "<value for organization>"
}

variable "ethNetworkPolicy"{
    type = string
    description = "Moid of Vnic.EthNetworkPolicy"

}