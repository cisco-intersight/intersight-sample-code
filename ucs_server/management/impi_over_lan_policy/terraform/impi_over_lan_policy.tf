
resource "intersight_ipmioverlan_policy" "ipmioverlan_policy" {
    name = "ipmioverlan_policy_1"
    description = "impioverlan policy sample"
    organization {
        object_type = "organization.Organization"
        moid = var.organization
    }
    privilege = "admin"
    enabled = true
    encryption_key = "xxxxxxxxxxxxxxxxxxxxxxxxxyyyyyyyyyyyyyyyyyy"
  
}

variable "organization" {
    type = string
    description = "<organization moid>"
  
}