provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_thermal_policy" "thermal_policy_1" {
  name              = "thermal_policy_1"
  fan_control_mode  = "Balanced"
  organization {
        object_type = "organization.Organization"
        moid = var.organization
    }
}

variable "organization" {
    type = string
    description = "<organization moid>"
  
}