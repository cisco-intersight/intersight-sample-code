provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}


resource "intersight_resourcepool_pool" "resource_pool" {
  name             = "Resource_pool_1"
  assignment_order = "sequential"
  pool_type        = "Static"
  
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  
  resource_pool_parameters {
    object_type    = "resourcepool.ServerPoolParameters"
    class_id       = "resourcepool.ServerPoolParameters"
    additional_properties = jsonencode({
      ResourcepoolServerPoolParameters = {
        ManagementMode = "IntersightStandalone"
      }
    })
  }
}

variable "organization" {
  type        = string
  description = "Moid of the organization"
}