provider "intersight" {
  endpoint  = "https://intersight.com"
  apikey    = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey = "C:\\secretKey.txt"
}

resource "intersight_ntp_policy" "ntp_policy" {
  name        = "ntp_policy_11"
  enabled     = true
  ntp_servers = ["22.22.22.33", "44.44.44.44"]
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_kvm_policy" "kvm_policy" {
  name                     = "kvm_policy_11"
  enable_local_server_video = true
  enable_video_encryption   = true
  enabled                  = true
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_bios_policy" "bios_policy" {
  name                    = "bios_policy_11"
  boot_option_retry       = "enabled"
  intel_turbo_boost_tech  = "enabled"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_server_profile_template" "server_profile_template" {
  name = "Server_Profile_template_1"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

  policy_bucket {
    moid        = intersight_ntp_policy.ntp_policy.moid
    object_type = "ntp.Policy"
    class_id    = "policy.AbstractPolicy"
    selector    = ""
  }

  policy_bucket {
    moid        = intersight_kvm_policy.kvm_policy.moid
    object_type = "kvm.Policy"
    class_id    = "policy.AbstractPolicy"
    selector    = ""
  }

  policy_bucket {
    moid        = intersight_bios_policy.bios_policy.moid
    object_type = "bios.Policy"
    class_id    = "policy.AbstractPolicy"
    selector    = ""
  }
}

variable "organization" {
  type        = string
  description = "Moid of the organization"
}