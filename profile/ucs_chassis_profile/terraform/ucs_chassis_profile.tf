provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_ippool_pool" "ippool_pool1" {
  name             = "ippool_pool1"
  description      = "ippool pool"
  assignment_order = "sequential"

  ip_v4_config {
    object_type = "ippool.IpV4Config"
    gateway     = "10.1.1.1"
    netmask     = "255.0.0.0"
    primary_dns = "8.8.8.8"
  }

  ip_v4_blocks {
    object_type = "ippool.IpV4Block"
    from        = "10.1.1.10"
    to          = "10.1.1.20"
  }

  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

resource "intersight_access_policy" "access1" {
  name        = "access1"
  description = "demo imc access policy"
  inband_vlan = 19
  inband_ip_pool {
    object_type = "ippool.Pool"
    moid        = intersight_ippool_pool.ippool_pool1.moid
  }

  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

resource "intersight_snmp_policy" "snmp1" {
  name                    = "snmp1"
  description             = "testing snmp policy"
  enabled                 = true
  snmp_port               = 1983
  access_community_string = "dummy123"
  community_access        = "Disabled"
  trap_community          = "TrapCommunity"
  sys_contact             = "aanimish"
  sys_location            = "Karnataka"
  engine_id               = "vvb"
  snmp_users {
    name             = "demouser"
    privacy_type     = "AES"
    auth_password    = var.auth_password
    privacy_password = var.privacy_password
    security_level   = "AuthPriv"
    auth_type        = "SHA"
    object_type      = "snmp.User"
  }
  snmp_traps {
    destination = "10.10.10.1"
    enabled     = false
    port        = 660
    type        = "Trap"
    user        = "demouser"
    nr_version  = "V3"
    object_type = "snmp.Trap"
  }
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

resource "intersight_thermal_policy" "sample_thermal_policy" {
  name         = "sample_thermal_policy"
  description  = "Sample thermal policy"
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

resource "intersight_power_policy" "sample_power_policy" {
  name         = "sample_power_policy"
  description  = "Sample power policy"
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}

resource "intersight_chassis_profile" "sample_chassis_profile" {
  name            = "chassis_profile1"
  description     = "chassis profile"
  type            = "instance"
  target_platform = "FIAttached"
  action          = "Validate"
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }

  policy_bucket {
    object_type = "access.Policy"
    moid        = intersight_access_policy.access1.moid
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    object_type = "snmp.Policy"
    moid        = intersight_snmp_policy.snmp1.moid
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    object_type = "thermal.Policy"
    moid        = intersight_thermal_policy.sample_thermal_policy.moid
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    object_type = "power.Policy"
    moid        = intersight_power_policy.sample_power_policy.moid
    class_id    = "policy.AbstractPolicy"
  }
}

variable "auth_password" {
  type        = string
  description = "value for auth_password"
}

variable "privacy_password" {
  type        = string
  description = "value for privacy password"
}