provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

# Define policies
resource "intersight_fabric_eth_network_policy" "fabric_eth_network_policy1" {
  name        = "fabric_eth_network_policy1"
  description = "fabric ethernet network policy"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy1" {
  name            = "fabric_fc_network_policy1"
  description     = "fabric FC network policy"
  enable_trunking = true
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_fabric_port_policy" "fabric_port_policy1" {
  name         = "fabric_port_policy1"
  description  = "demo fabric port policy"
  device_model = "UCS-FI-6454"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_fabric_system_qos_policy" "fabric_system_qos_policy1" {
  name        = "fabric_system_qos_policy1"
  description = "demo fabric system qos policy"
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 80
    cos                = 255
    mtu                = 2240
    multicast_optimize = true
    name               = "Best Effort"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"
    weight             = 5
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_fabric_switch_control_policy" "fabric_switch_control_policy1" {
  name        = "fabric_switch_control_policy1"
  description = "fabric switch control policy"
  mac_aging_settings {
    mac_aging_option = "Custom"
    mac_aging_time   = 3000
    object_type      = "fabric.MacAgingSettings"
  }
  vlan_port_optimization_enabled = true
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_ntp_policy" "ntp1" {
  name        = "ntp1"
  description = "test policy"
  enabled     = true
  ntp_servers = [
    "ntp.esl.cisco.com",
    "time-a-g.nist.gov",
    "time-b-g.nist.gov"
  ]
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_networkconfig_policy" "network_config1" {
  name                     = "network_config1"
  description              = "demo network configuration policy"
  enable_dynamic_dns       = false
  preferred_ipv6dns_server = "::"
  enable_ipv6              = true
  enable_ipv6dns_from_dhcp = false
  preferred_ipv4dns_server = "10.10.10.1"
  alternate_ipv4dns_server = "10.10.10.1"
  alternate_ipv6dns_server = "::"
  dynamic_dns_domain       = ""
  enable_ipv4dns_from_dhcp = false
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

# Create a cluster switch profile
resource "intersight_fabric_switch_cluster_profile" "cluster_switch_profile_1" {
  name = "cluster_switch_profile_1"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

# Create a domain profile for Fabric switch A
resource "intersight_fabric_switch_profile" "fabric_A_profile" {
  name                = "Fabric_A_profile"
  switch_cluster_profile {
    object_type = "fabric.SwitchClusterProfile"
    moid        = intersight_fabric_switch_cluster_profile.cluster_switch_profile_1.moid
  }
  policy_bucket = [
    {
      additional_properties = ""
      class_id              = "fabric.EthNetworkPolicy"
      object_type           = "fabric.EthNetworkPolicy"
      moid                  = intersight_fabric_eth_network_policy.fabric_eth_network_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.FcNetworkPolicy"
      object_type           = "fabric.FcNetworkPolicy"
      moid                  = intersight_fabric_fc_network_policy.fabric_fc_network_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.PortPolicy"
      object_type           = "fabric.PortPolicy"
      moid                  = intersight_fabric_port_policy.fabric_port_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.SystemQosPolicy"
      object_type           = "fabric.SystemQosPolicy"
      moid                  = intersight_fabric_system_qos_policy.fabric_system_qos_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.SwitchControlPolicy"
      object_type           = "fabric.SwitchControlPolicy"
      moid                  = intersight_fabric_switch_control_policy.fabric_switch_control_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "ntp.Policy"
      object_type           = "ntp.Policy"
      moid                  = intersight_ntp_policy.ntp1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "networkconfig.Policy"
      object_type           = "networkconfig.Policy"
      moid                  = intersight_networkconfig_policy.network_config1.moid
      selector              = ""
    },
  ]
}

# Create a domain profile for Fabric switch B
resource "intersight_fabric_switch_profile" "fabric_B_profile" {
  name                = "Fabric_B_profile"
  switch_cluster_profile {
    object_type = "fabric.SwitchClusterProfile"
    moid        = intersight_fabric_switch_cluster_profile.cluster_switch_profile_1.moid
  }
  policy_bucket = [
    {
      additional_properties = ""
      class_id              = "fabric.EthNetworkPolicy"
      object_type           = "fabric.EthNetworkPolicy"
      moid                  = intersight_fabric_eth_network_policy.fabric_eth_network_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.FcNetworkPolicy"
      object_type           = "fabric.FcNetworkPolicy"
      moid                  = intersight_fabric_fc_network_policy.fabric_fc_network_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.PortPolicy"
      object_type           = "fabric.PortPolicy"
      moid                  = intersight_fabric_port_policy.fabric_port_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.SystemQosPolicy"
      object_type           = "fabric.SystemQosPolicy"
      moid                  = intersight_fabric_system_qos_policy.fabric_system_qos_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "fabric.SwitchControlPolicy"
      object_type           = "fabric.SwitchControlPolicy"
      moid                  = intersight_fabric_switch_control_policy.fabric_switch_control_policy1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "ntp.Policy"
      object_type           = "ntp.Policy"
      moid                  = intersight_ntp_policy.ntp1.moid
      selector              = ""
    },
    {
      additional_properties = ""
      class_id              = "networkconfig.Policy"
      object_type           = "networkconfig.Policy"
      moid                  = intersight_networkconfig_policy.network_config1.moid
      selector              = ""
    },
  ]
}

variable "organization" {
  type        = string
  description = "Moid of the organization"
}
