provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_chassis_profile" "chassis_profile1" {
  name            = "chassis_profile1"
  description     = "chassis profile"
  type            = "instance"
  target_platform = "FIAttached"
  action          = "Validate"
  config_context {
    object_type    = "policy.ConfigContext"
    control_action = "deploy"
    error_state    = "Validation-error"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}