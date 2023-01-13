resource "intersight_fabric_flow_control_policy" "fabric_flow_policy" {
    name = "fabric_flow_policy_1"
    description = "sample fabric flow policy"
    organization  {
        object_type = "organization.Organization"
        moid = var.organization
    }
    receive_direction = "Enabled"
    send_direction = "Enabled"
    priority_flow_control_mode = "off"
  
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }