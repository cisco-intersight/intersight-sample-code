provider "intersight" {
  endpoint  = "https://intersight.com"
  apikey    = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey = "C:\\secretKey.txt"
}

resource "intersight_ssh_policy" "ssh_policy1" {
  name        = "ssh_policy1"
  description = "ssh policy"
  enabled     = true
  port        = 22
  timeout     = 1800
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
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
  description = "Moid of the server profile."
}
