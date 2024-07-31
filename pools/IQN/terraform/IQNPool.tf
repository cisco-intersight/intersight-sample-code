provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_iqnpool_pool" "iqnpool_pool1" {
  name             = "ippool_pool1"
  description      = "ippool pool"
  assignment_order = "sequential"
  prefix           = "iqn.2023-06.abc.com"
  
  iqn_suffix_blocks {
    object_type = "iqn.SuffixBlocks"
    suffix      = "iscsi01"
    from = 0
    to = 9
  }

  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}