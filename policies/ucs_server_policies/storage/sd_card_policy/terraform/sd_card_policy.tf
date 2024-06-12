provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_sdcard_policy" "sdcard1" {
  name        = "sdcard1"
  description = "demo sd card policy"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  partitions {
    type        = "OS"
    object_type = "sdcard.Partition"

    virtual_drives {
      enable      = true
      object_type = "sdcard.OperatingSystem"
      additional_properties = jsonencode({
        Name = "Hypervisor"
      })
    }
  }
}

 variable "organization" {
   type = string
   description = "<value for organization>"
 }