provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_iam_end_point_user" "guest_user" {
  name = "guest"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_iam_end_point_user_policy" "user_policy" {
  name = "user_policy_1"
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

resource "intersight_iam_end_point_user_role" "user_role" {
  enabled           = true
  end_point_role {
    object_type = "iam.EndPointRole"
    moid        = var.admin_role_moid
  }
  password          = "admin@1234"
  end_point_user {
    object_type = "iam.EndPointUser"
    moid        = intersight_iam_end_point_user.guest_user.moid
  }
  end_point_user_policy {
    object_type = "iam.EndPointUserPolicy"
    moid        = intersight_iam_end_point_user_policy.user_policy.moid
  }
}

variable "organization" {
 type        = string
  description = "Moid of organization"
}

variable "admin_role_moid" {
  type        = string
  description = "MOID of the admin role"
}