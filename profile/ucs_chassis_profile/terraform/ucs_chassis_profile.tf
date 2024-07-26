provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

data "intersight_access_policy" "access_policy_1" {
  name = "access_policy_1"
}

data "intersight_snmp_policy" "snmp_policy_1" {
  name = "snmp_policy_1"
}

data "intersight_thermal_policy" "thermal_policy_1" {
  name = "thermal_policy_1"
}

data "intersight_power_policy" "power_policy_1" {
  name = "power_policy_1"
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
    moid        = data.intersight_access_policy.access_policy_1.id
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    object_type = "snmp.Policy"
    moid        = data.intersight_snmp_policy.snmp_policy_1.id
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    object_type = "thermal.Policy"
    moid        = data.intersight_thermal_policy.thermal_policy_1.id
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    object_type = "power.Policy"
    moid        = data.intersight_power_policy.power_policy_1.id
    class_id    = "policy.AbstractPolicy"
  }
}