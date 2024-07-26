provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

data "intersight_ntp_policy" "ntp_policy" {
  name = "ntp1"
}

data "intersight_smtp_policy" "smtp_policy" {
  name = "smtp1"
}

data "intersight_snmp_policy" "snmp_policy" {
  name = "snmp1"
}

resource "intersight_server_profile" "server_profile" {
  name               = "ss_server_profile1"
  description        = "A sample server profile"
  target_platform    = "Standalone"
  
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }

  tags {
    key   = "server"
    value = "demo"
  }

  policy_bucket {
    moid        = data.intersight_ntp_policy.ntp_policy.id
    object_type = "ntp.Policy"
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    moid        = data.intersight_smtp_policy.smtp_policy.id
    object_type = "smtp.Policy"
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    moid        = data.intersight_snmp_policy.snmp_policy.id
    object_type = "snmp.Policy"
    class_id    = "policy.AbstractPolicy"
  }
}