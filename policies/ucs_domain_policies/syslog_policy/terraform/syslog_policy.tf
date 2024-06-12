provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_syslog_policy" "syslog_policy1" {
  name        = "sys_log_policy1"
  description = "Syslog policy for sample"
  
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

  local_clients {
    min_severity = "emergency"
    object_type  = "syslog.LocalFileLoggingClient"
  }

  remote_clients {
    enabled      = true
    hostname     = "11.11.11.11"
    port         = 514
    protocol     = "udp"
    min_severity = "warning"
    object_type  = "syslog.RemoteLoggingClient"
  }
  
  remote_clients {
    enabled      = true
    hostname     = "2001:0db8:0a0b:12f0:0000:0000:0000:0004"
    port         = 64000
    protocol     = "udp"
    min_severity = "emergency"
    object_type  = "syslog.RemoteLoggingClient"
  }
  
  profiles {
    moid        = var.profile
    object_type = "server.Profile"
  }
}

variable "organization" {
  type        = string
  description = "Moid of the organization"
}

variable "profile" {
  type        = string
  description = "Moid of server.Profile"
}