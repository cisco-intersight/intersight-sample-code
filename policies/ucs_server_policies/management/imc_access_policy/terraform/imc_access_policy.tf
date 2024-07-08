provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_ippool_pool" "ipv4_pool" {
  name = "ipv4_ippool_1"
  description = "ip pool with IPv4 block and config"
  assignment_order = "default"

  ip_v4_blocks {
    from = "10.128.130.100"
    size = 10
  }

  ip_v4_config {
    gateway = "10.128.130.254"
    netmask = "255.255.255.0"
    primary_dns = "8.8.8.8"
  }

  organization {
    object_type = "organization.Organization"
    moid = var.organization
  }
}


resource "intersight_access_policy" "access_policy" {
  name        = "access_policy_1"
  description = "Access policy with IP pool"
  inband_vlan = 144

  inband_ip_pool {
    object_type = "ippool.Pool"
    moid = intersight_ippool_pool.ipv4_pool.moid
  }

  organization {
    object_type = "organization.Organization"
    moid = var.organization
  }

  configuration_type {
    configure_inband = true
    configure_out_of_band = false
    object_type = "access.ConfigurationType"
  }

  address_type {
    object_type = "access.AddressType"
    enable_ip_v4 = true
    enable_ip_v6 = false
  }
}

variable "organization" {
 type = string
  description = "Moid of organization"
}