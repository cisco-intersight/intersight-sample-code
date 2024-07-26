provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_ipmioverlan_policy" "ipmioverlan_policy" {
    name = "ipmi_over_lan_1"
    description = "impi overlan policy"
    organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }
    privilege = "admin"
    enabled = true
    encryption_key = "xxxxxxxxxxxxxxxxxxxxxxxxxyyyyyyyyyyyyyyyyyy"
}