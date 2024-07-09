provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_macpool_pool" "mac_pool" {
  name             = "MAC_pool_1"
  assignment_order = "sequential"
   
   mac_blocks {
    from = "00:25:B5:00:00:01"
    size = 10
  }
  
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}