resource "intersight_networkconfig_policy" "networkconfig_policy"{
    name = "netwrok_config_policy_1"
    description = "demo network config policy"
    organization  {
        object_type = "organization.Organization"
        moid = var.organization
    }
    enable_dynamic_dns = true
    dynamic_dns_domain = "xyz.com"
    preferred_ipv4dns_server = "171.70.98.1"
    alternate_ipv4dns_server = "22.22.22.22"

}


variable "organization"{
    type = string
    description = "<value for organization>"
}
