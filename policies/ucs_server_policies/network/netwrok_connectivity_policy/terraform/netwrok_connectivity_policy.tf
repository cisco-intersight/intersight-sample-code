# Set up intersight environment
provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_networkconfig_policy" "network_config1" {
  name                     = "netwrokConfigPolicy"
  description              = "network configuration policy"
  enable_dynamic_dns       = false
  preferred_ipv6dns_server = "::"
  enable_ipv6              = true
  enable_ipv6dns_from_dhcp = false
  preferred_ipv4dns_server = "10.10.10.1"
  alternate_ipv4dns_server = "10.10.10.1"
  alternate_ipv6dns_server = "::"
  dynamic_dns_domain       = ""
  enable_ipv4dns_from_dhcp = false
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
}