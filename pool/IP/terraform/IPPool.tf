provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_ippool_pool" "ippool_pool1" {
  name             = "ippool_pool1"
  description      = "ippool pool"
  assignment_order = "sequential"
  
  ip_v4_config {
    object_type = "ippool.IpV4Config"
    gateway     = "10.108.190.1"
    netmask     = "255.255.255.0"
    primary_dns = "10.108.190.100"
  }
  
  ip_v4_blocks {
    from = "10.108.190.11"
    to   = "10.108.190.20"
  }
  
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}