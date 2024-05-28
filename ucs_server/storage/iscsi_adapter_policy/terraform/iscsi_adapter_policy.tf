# Set up intersight environment
provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_vnic_iscsi_adapter_policy" "vnic_iscsi_adapter_policy" {
  name                 = "vnic_iscsi_adapter_policy1"
  description          = "vnic iscsi adapter policy"
  dhcp_timeout         = 60
  lun_busy_retry_count = 15
  connection_time_out  = 15
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }