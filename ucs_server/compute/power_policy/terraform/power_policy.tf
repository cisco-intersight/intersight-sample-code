
resource "intersight_power_policy" "power_policy_1" {
    name = "power_policy_1"
    description = "sample power policy"
    organization {
        object_type = "organization.Organization"
        moid = var.organization
    }
    dynamic_rebalancing = "Enabled"
    extended_power_capacity = "Enabled"
    power_priority = "High"
    power_profiling = "Enabled"
    power_restore_state = "AlwaysOff"
    power_save_mode = "Enabled"
    redundancy_mode = "Grid"

  
}

variable "organization" {
  type  = string
  description = "<organization moid>"
}