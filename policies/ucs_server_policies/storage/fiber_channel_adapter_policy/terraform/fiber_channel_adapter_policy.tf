# Set up intersight environment
provider "intersight" {
  endpoint        = "https://intersight.com"
  apikey          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
  secretkey       = "C:\\secretKey.txt"
}

data "intersight_organization_organization" "organization" {
  name = "default"
}

resource "intersight_vnic_fc_adapter_policy" "v_fc_adapter1" {
  name                    = "v_fc_adapter1"
  error_detection_timeout = 2000
  
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.organization.id
  }
  error_recovery_settings {
    enabled           = true
    io_retry_count    = 8
    io_retry_timeout  = 5
    link_down_timeout = 3000
    port_down_timeout = 5000
    object_type       = "vnic.FcErrorRecoverySettings"
  }

  flogi_settings {
    retries     = 0
    timeout     = 4000
    object_type = "vnic.FlogiSettings"
  }

  interrupt_settings {
    mode        = "INTx"
    object_type = "vnic.FcInterruptSettings"
  }

  io_throttle_count = 512
  lun_count         = 1024
  lun_queue_depth   = 20

  plogi_settings {
    retries     = 8
    timeout     = 3000
    object_type = "vnic.PlogiSettings"
  }
  resource_allocation_timeout = 10000

  rx_queue_settings {
    ring_size   = 64
    object_type = "vnic.FcQueueSettings"
  }
  tx_queue_settings {
    ring_size   = 64
    object_type = "vnic.FcQueueSettings"
  }

  scsi_queue_settings {
    nr_count    = 1
    ring_size   = 512
    object_type = "vnic.ScsiQueueSettings"
  }
}