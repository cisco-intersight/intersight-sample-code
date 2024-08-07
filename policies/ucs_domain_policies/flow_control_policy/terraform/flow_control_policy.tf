provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_flow_control_policy" "fabric_flow_policy" {
  name        = "fabric_flow_policy_1"
  description = "sample fabric flow policy"
  organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }
  receive_direction          = "Enabled"
  send_direction             = "Enabled"
  priority_flow_control_mode = "off"
}