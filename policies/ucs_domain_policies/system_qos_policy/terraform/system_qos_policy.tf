provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_system_qos_policy" "qos_policy" {
  name         = "qos_policy_1"
  description  = "Fabric system QoS policy"
  
  organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 22
    cos                = 5
    mtu                = 1500
    packet_drop        = true
    name               = "Platinum"
    weight             = 10
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 20
    cos                = 4
    mtu                = 1500
    packet_drop        = true
    name               = "Gold"
    weight             = 9
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 15
    cos                = 1
    mtu                = 1500
    packet_drop        = true
    name               = "Silver"
    weight             = 7
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"
  }

  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 18
    cos                = 2
    mtu                = 1500
    packet_drop        = true
    name               = "Bronze"
    weight             = 8
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"
  }
}