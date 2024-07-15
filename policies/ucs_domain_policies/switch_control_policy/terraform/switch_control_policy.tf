provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_switch_control_policy" "fabric_switch_control_policy1" {
  name        = "fabric_switch_control_policy1"
  description = "fabric switch control policy"
  mac_aging_settings {
    mac_aging_option = "Custom"
    mac_aging_time   = 14500
    object_type      = "fabric.MacAgingSettings"
  }
  udld_settings {
    message_interval = 12
    recovery_action  = "none"
  }

  vlan_port_optimization_enabled = true
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}
