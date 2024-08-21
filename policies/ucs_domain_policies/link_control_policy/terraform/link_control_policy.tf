provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_fabric_link_control_policy" "link_control_policy"{
    name = "fabric_link_policy"
    description = "sample fabric link control"
    organization {
      object_type = "organization.Organization"
      moid = data.intersight_organization_organization.organization.id
    }
    udld_settings  {
        object_type = "fabric.UdldSettings"
        admin_state = "Enabled"

    }
}