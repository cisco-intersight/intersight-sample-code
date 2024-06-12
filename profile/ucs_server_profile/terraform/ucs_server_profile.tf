provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_ntp_policy" "ntp_policy" {
  name        = "ntp1"
  description = "test policy"
  enabled     = true
  ntp_servers = ["ntp.esl.cisco.com", "time-a-g.nist.gov", "time-b-g.nist.gov"]

  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

# Create SMTP policy
resource "intersight_smtp_policy" "smtp_policy" {
  name             = "smtp1"
  description      = "testing smtp policy"
  enabled          = false
  smtp_port        = 32
  min_severity     = "critical"
  smtp_server      = "10.10.10.1"
  sender_email     = "IMCSQAAutomation@cisco.com"
  smtp_recipients  = ["aw@cisco.com", "cy@cisco.com", "dz@cisco.com"]

  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

# Create SNMP policy
resource "intersight_snmp_policy" "snmp_policy" {
  name                    = "snmp1"
  description             = "testing smtp policy"
  enabled                 = true
  snmp_port               = 1983
  access_community_string = "dummy123"
  community_access        = "Disabled"
  trap_community          = "TrapCommunity"
  sys_contact             = "xyz"
  sys_location            = "SJC"
  engine_id               = "abc"

  snmp_users {
    name           = "demouser"
    privacy_type   = "AES"
    security_level = "AuthPriv"
    auth_type      = "SHA"
    auth_password  = "dummyPassword"
    privacy_password = "dummyPrivatePassword"
  }

  snmp_traps {
    destination = "10.10.10.1"
    enabled     = false
    type        = "Trap"
    user        = "demouser"
    port        = 660
    object_type = "SnmpTrap"
  }

  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

# Assign the server profile to a server
resource "intersight_server_profile" "server_profile" {
  name               = "ss_server_profile1"
  description        = "A sample server profile"
  target_platform    = "Standalone"
  
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

  tags {
    key   = "server"
    value = "demo"
  }

  policy_bucket {
    moid        = intersight_ntp_policy.ntp_policy.moid
    object_type = intersight_ntp_policy.ntp_policy.object_type
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    moid        = intersight_smtp_policy.smtp_policy.moid
    object_type = intersight_smtp_policy.smtp_policy.object_type
    class_id    = "policy.AbstractPolicy"
  }

  policy_bucket {
    moid        = intersight_snmp_policy.snmp_policy.moid
    object_type = intersight_snmp_policy.snmp_policy.object_type
    class_id    = "policy.AbstractPolicy"
  }
}

variable "organization" {
  type        = string
  description = "Moid of the organization"
}