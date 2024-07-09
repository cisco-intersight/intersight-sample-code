provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_vmedia_policy" "vmedia1" {
  name          = "vmedia1"
  description   = "demo vmedia policy"
  enabled       = true
  encryption    = true
  low_power_usb = true
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
  mappings {
    class_id       = "vmedia.Mapping"
    device_type    = "cdd"
    file_location  = "infra-chx.auslab.cisco.com/software/linux/ubuntu-18.04.5-server-amd64.iso"
    host_name      = "infra-chx.auslab.cisco.com"
    mount_options  = "RO"
    mount_protocol = "nfs"
    object_type    = "vmedia.Mapping"
    remote_file    = "ubuntu-18.04.5-server-amd64.iso"
    remote_path    = "/iso/software/linux"
    volume_name    = "IMC_DVD"
  }
}