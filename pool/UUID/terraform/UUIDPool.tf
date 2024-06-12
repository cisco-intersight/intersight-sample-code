provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}


resource "intersight_uuidpool_pool" "uuid_pool" {
  name              = "uuuid_pool_1"
  prefix            = "00000000-0000-00A0"
  uuid_suffix_blocks {
    from = "0000-001234500A00"
    size = 100
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

variable "organization" {
  type        = string
  description = "Moid of the organization"
}