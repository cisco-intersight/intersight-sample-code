resource "intersight_fabric_link_control_policy" "link_control_policy"{
    name = "fabric_link_policy"
    description = "sample fabric link control"
    organization  {
        object_type = "organization.Organization"
        moid = var.organization
    }
    udld_settings  {
        object_type = "fabric.UdldSettings"
        admin_state = "Enabled"

    }
}


variable "organization"{
    type = string
    description = "<value for organization>"
}
