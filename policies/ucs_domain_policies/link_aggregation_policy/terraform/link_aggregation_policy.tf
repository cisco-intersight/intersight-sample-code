provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_fabric_link_aggregation_policy" "fabric_link_aggregation_policy"{
    name = "link_aggregate_policy_1"
    description = "sample link aggregate policy"
    organization = {
        object_type = "organization.Organization"
        moid = var.organization
    }
    lacp_rate = "fast"
    suspend_individual = true

}

variable "organization"{
    type = string
    description = "<value for organization>"

}