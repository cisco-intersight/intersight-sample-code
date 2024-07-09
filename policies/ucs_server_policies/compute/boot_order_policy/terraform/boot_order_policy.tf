provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_boot_precision_policy" "boot_precision1" {
  name                     = "boot_precision1"
  description              = "test policy"
  configured_boot_mode     = "Uefi"  
  enforce_uefi_secure_boot = false

  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }

  boot_devices {
    enabled     = true
    name        = "vMedia"
    object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "cimc-mapped-dvd"  
    })
  }

  boot_devices {
    enabled     = true
    name        = "usb"
    object_type = "boot.Usb"
    additional_properties = jsonencode({
      Subtype = "usb-fdd"  
    })
  }

  boot_devices {
    enabled     = true
    name        = "uefi"
    object_type = "boot.UefiShell"
  }

  boot_devices {
    enabled     = true
    name        = "primary_1"
    object_type = "boot.Pxe"
    additional_properties = jsonencode({
      InterfaceName = "eth0"
      IpType        = "IPv4"
    })
  }

  boot_devices {
    enabled     = true
    name        = "secondary"
    object_type = "boot.San"
    additional_properties = jsonencode({
      InterfaceName = "fc0"
      Wwpn          = "50:06:01:62:3E:E0:58:36"
      Bootloader    = {
        Name        = "bootLoader"
        ObjectType  = "boot.Bootloader"
      }
    })
  }
}