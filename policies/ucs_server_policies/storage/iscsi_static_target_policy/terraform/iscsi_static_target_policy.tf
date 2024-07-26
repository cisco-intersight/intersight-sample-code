# Set up intersight environment
provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_vnic_iscsi_static_target_policy" "vnic_iscsi_static_target_policy" {
  name        = "iscsi_target_policy_1"
  description = "vnic iscsi static target policy"
  target_name = "iqn.2024-05.com"
  ip_address  = "10.1.1.1"
  port        = 3260
  lun {
    class_id    = "vnic.Lun"
    object_type = "vnic.Lun"
    bootable    = true
    lun_id      = 4
  }
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}
