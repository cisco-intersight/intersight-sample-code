resource "intersight_fabric_eth_network_group_policy" "eth_network_group_policy"{
    name = "fabric_ethNetork_group_policy_1"
    description = "sample fabric eth network group policy"
    organization  {
        object_type = "organization.Organization"
        moid = var.organization
    }
    vlan_settings {
        object_type   = "fabric.VlanSettings"
        allowed_vlans = "14,313,315"
        native_vlan = 14
    }
}

variable "organization"{
    type = string
    description = "<value for organization>"
}