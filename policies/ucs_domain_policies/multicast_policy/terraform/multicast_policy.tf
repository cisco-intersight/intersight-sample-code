provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy1" {
  name = "fabric_multicast_policy1"
  description = "demo fabric multicast policy"
  querier_ip_address = "192.168.0.1"
  querier_state = "Enabled"
  snooping_state = "Enabled"
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}