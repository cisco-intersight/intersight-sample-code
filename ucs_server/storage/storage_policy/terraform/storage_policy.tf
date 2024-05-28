# Set up intersight environment
provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_storage_storage_policy" "tf_storage_policy" {
  name                     = "tf_storage_policy"
  use_jbod_for_vd_creation = true
  description              = "storage policy test"
  unused_disks_state       = "UnconfiguredGood"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  global_hot_spares = "3"
  m2_virtual_drive {
    enable      = false
    object_type = "storage.M2VirtualDriveConfig"
  }
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }