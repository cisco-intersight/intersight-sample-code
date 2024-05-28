provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

resource "intersight_adapter_config_policy" "adapter_config1" {
  name        = "adapter_config1"
  description = "test policy"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  settings {
    object_type = "adapter.AdapterConfig"
    slot_id     = "1"
    eth_settings {
      lldp_enabled = true
      object_type  = "adapter.EthSettings"
    }
    fc_settings {
      object_type = "adapter.FcSettings"
      fip_enabled = true
    }
  }
  settings {
    object_type = "adapter.AdapterConfig"
    slot_id     = "MLOM"
    eth_settings {
      object_type  = "adapter.EthSettings"
      lldp_enabled = true
    }
    fc_settings {
      object_type = "adapter.FcSettings"
      fip_enabled = true
    }
  }
  profiles {
    moid        = server.moid
    object_type = "server.Profile"
  }
}

variable "server" {
  type = string
  description = "Moid of server.Profile"
}

variable "organization" {
   type = string
   description = "<value for organization>"
 }