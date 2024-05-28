provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_iam_end_point_user_policy" "user_policy1" {
  name        = "user_policy1"
  description = "test policy"

  password_properties {
    enforce_strong_password  = true
    enable_password_expiry   = true
    password_expiry_duration = 50
    password_history         = 5
    notification_period      = 1
    grace_period             = 2
    object_type              = "iam.EndPointPasswordProperties"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

variable "organization" {
  type        = string
  description = "value for organization"
}