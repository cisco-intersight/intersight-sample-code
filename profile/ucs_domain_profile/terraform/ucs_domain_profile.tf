provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

data "intersight_fabric_eth_network_policy" "eth_network_policy_1" {
  name = "eth_network_policy_1"
}

data "intersight_fabric_fc_network_policy" "fc_network_policy_1" {
  name = "fc_network_policy_1"
}

data "intersight_fabric_port_policy" "port_policy_1" {
  name = "port_policy_1"
}

data "intersight_fabric_system_qos_policy" "system_qos_policy_1" {
  name = "system_qos_policy_1"
}

data "intersight_fabric_switch_control_policy" "switch_control_policy_1" {
  name = "switch_control_policy_1"
}

data "intersight_ntp_policy" "ntp_policy_1" {
  name = "ntp_policy_1"
}

data "intersight_networkconfig_policy" "network_config_policy_1" {
  name = "network_config_policy_1"
}

data "intersight_syslog_policy" "syslog_policy_1"{
  name = "syslog_policy_1"
}

resource "intersight_fabric_switch_cluster_profile" "cluster_switch_profile_1" {
  name = "cluster_switch_profile_1"
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

resource "intersight_fabric_switch_profile" "fabric_A_profile" {
  name                = "Fabric_A_profile"
  switch_cluster_profile {
    object_type = "fabric.SwitchClusterProfile"
    moid        = intersight_fabric_switch_cluster_profile.cluster_switch_profile_1.moid
  }

  policy_bucket {
    class_id    = "fabric.EthNetworkPolicy"
    object_type = "fabric.EthNetworkPolicy"
    moid        = data.intersight_fabric_eth_network_policy.eth_network_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.FcNetworkPolicy"
    object_type = "fabric.FcNetworkPolicy"
    moid        = data.intersight_fabric_fc_network_policy.fc_network_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.PortPolicy"
    object_type = "fabric.PortPolicy"
    moid        = data.intersight_fabric_port_policy.port_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.SystemQosPolicy"
    object_type = "fabric.SystemQosPolicy"
    moid        = data.intersight_fabric_system_qos_policy.system_qos_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.SwitchControlPolicy"
    object_type = "fabric.SwitchControlPolicy"
    moid        = data.intersight_fabric_switch_control_policy.switch_control_policy_1.id
  }

  policy_bucket {
    class_id    = "ntp.Policy"
    object_type = "ntp.Policy"
    moid        = data.intersight_ntp_policy.ntp_policy_1.id
  }

  policy_bucket {
    class_id    = "networkconfig.Policy"
    object_type = "networkconfig.Policy"
    moid        = data.intersight_networkconfig_policy.network_config_policy_1.id
  }

  policy_bucket {
    class_id = "syslog.Policy"
    object_type = "syslog.Policy"
    moid = data.intersight_syslog_policy.syslog_policy_1.id
  }
}

resource "intersight_fabric_switch_profile" "fabric_B_profile" {
  name                = "Fabric_B_profile"
  switch_cluster_profile {
    object_type = "fabric.SwitchClusterProfile"
    moid        = intersight_fabric_switch_cluster_profile.cluster_switch_profile_1.moid
  }

  policy_bucket {
    class_id    = "fabric.EthNetworkPolicy"
    object_type = "fabric.EthNetworkPolicy"
    moid        = data.intersight_fabric_eth_network_policy.eth_network_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.FcNetworkPolicy"
    object_type = "fabric.FcNetworkPolicy"
    moid        = data.intersight_fabric_fc_network_policy.fc_network_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.PortPolicy"
    object_type = "fabric.PortPolicy"
    moid        = data.intersight_fabric_port_policy.port_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.SystemQosPolicy"
    object_type = "fabric.SystemQosPolicy"
    moid        = data.intersight_fabric_system_qos_policy.system_qos_policy_1.id
  }

  policy_bucket {
    class_id    = "fabric.SwitchControlPolicy"
    object_type = "fabric.SwitchControlPolicy"
    moid        = data.intersight_fabric_switch_control_policy.switch_control_policy_1.id
  }

  policy_bucket {
    class_id    = "ntp.Policy"
    object_type = "ntp.Policy"
    moid        = data.intersight_ntp_policy.ntp_policy_1.id
  }

  policy_bucket {
    class_id    = "networkconfig.Policy"
    object_type = "networkconfig.Policy"
    moid        = data.intersight_networkconfig_policy.network_config_policy_1.id
  }

  policy_bucket {
    class_id = "syslog.Policy"
    object_type = "syslog.Policy"
    moid = data.intersight_syslog_policy.syslog_policy_1.id
  }
}