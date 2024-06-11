provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_firmware_policy" "firmware_policy" {
  name             = "firmware_policy_1"
  target_platform  = "Standalone"
  model_bundle_combo {
    model_family   = "UCSC-C220-M7"
    bundle_version = "4.3(3.240043)"
  }
  organization {
        object_type = "organization.Organization"
        moid = var.organization
    }
}

variable "organization" {
    type = string
    description = "<organization moid>"
  
}


