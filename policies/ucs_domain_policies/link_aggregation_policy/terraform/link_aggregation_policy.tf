provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_link_aggregation_policy" "fabric_link_aggregation_policy"{
    name = "LinkAgrregate"
    description = "Link Aggregation policy"
    organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }
    lacp_rate = "fast"
    suspend_individual = true
}