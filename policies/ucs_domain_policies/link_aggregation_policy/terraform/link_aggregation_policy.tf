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