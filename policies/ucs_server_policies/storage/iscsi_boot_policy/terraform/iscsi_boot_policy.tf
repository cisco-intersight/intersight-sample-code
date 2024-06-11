provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_vnic_iscsi_boot_policy" "vnic_iscsi_boot_policy" {
  name                           = "vnic_iscsi_boot_policy1"
  description                    = "vnic iscsi boot policy"
  initiator_ip_source            = "Static"
  target_source_type             = "Static"
  initiator_static_ip_v4_address = "172.16.2.19"

  chap {
    password    = "test@11234567"
    user_id     = "test"
    object_type = "vnic.IscsiAuthProfile"
  }

  mutual_chap {
    password    = "test@1234567"
    user_id     = "admin"
    object_type = "vnic.IscsiAuthProfile"
  }

  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

  initiator_static_ip_v4_config {
    gateway = "172.16.2.1"
    netmask = "255.255.255.0"
  }

  primary_target_policy {
    object_type = "vnic.IscsiStaticTargetPolicy"
    moid        = var.primary_target_policy_moid
  }
}


variable "primary_target_policy_moid" {
  type        = string
  description = "<Moid of the primary target policy>"
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }
