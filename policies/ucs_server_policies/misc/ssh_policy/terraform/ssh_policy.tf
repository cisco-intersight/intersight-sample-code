provider "intersight" {
  endpoint  = "https://intersight.com"
  apikey    = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_ssh_policy" "ssh_policy1" {
  name        = "ssh_policy_1"
  description = "ssh policy"
  enabled     = true
  port        = 12000
  timeout     = 1800
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}
