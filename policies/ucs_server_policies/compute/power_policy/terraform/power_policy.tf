provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_power_policy" "power_policy_1" {
    name = "power_policy_1"
    description = "sample power policy"
    organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }
    dynamic_rebalancing = "Disabled"
    extended_power_capacity = "Enabled"
    power_priority = "Low"
    power_profiling = "Enabled"
    power_restore_state = "AlwaysOff"
    power_save_mode = "Enabled"
    redundancy_mode = "Grid" 
}