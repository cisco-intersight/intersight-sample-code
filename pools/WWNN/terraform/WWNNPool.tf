provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fcpool_pool" "fcpool_pool1" {
  name             = "wwnn_pool_1"
  description      = "wwnn pool_1"
  assignment_order = "default"
  id_blocks {
    object_type = "fcpool.Block"
     from = "20:00:00:25:B5:00:00:01"
     size = 100
  }
  pool_purpose = "WWNN"
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}