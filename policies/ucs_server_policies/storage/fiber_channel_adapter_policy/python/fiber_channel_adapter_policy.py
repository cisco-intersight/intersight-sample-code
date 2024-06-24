import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_fc_adapter_policy import VnicFcAdapterPolicy
from intersight.model.vnic_fc_error_recovery_settings import VnicFcErrorRecoverySettings
from intersight.model.vnic_flogi_settings import VnicFlogiSettings
from intersight.model.vnic_fc_interrupt_settings import VnicFcInterruptSettings
from intersight.model.vnic_plogi_settings import VnicPlogiSettings
from intersight.model.vnic_fc_queue_settings import VnicFcQueueSettings
from intersight.model.vnic_scsi_queue_settings import VnicScsiQueueSettings
api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_fiber_channel_adapter_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create an instance of VnicFcErrorRecoverySettings
    error_recovery_settings = VnicFcErrorRecoverySettings(enabled=True,
                                                        io_retry_count=8,
                                                        io_retry_timeout=5,
                                                        link_down_timeout=3000,
                                                        port_down_timeout=5000)
    # Create an instance of VnicFlogiSettings
    flogi_settings = VnicFlogiSettings(retries=0, timeout=4000)
    # Create an instance of VnicFcInterruptSettings
    interrupt_settings = VnicFcInterruptSettings(mode="INTx")
    # Create instance of VnicPlogiSettings
    plogi_settings = VnicPlogiSettings(retries=8, timeout=3000)
    # Create an instance of VnicFcQueueSettings
    rx_queue_settings = VnicFcQueueSettings(ring_size=64)
    # Create an instance of VnicScsiQueueSettings
    scsi_queue_settings = VnicScsiQueueSettings(count=1, ring_size=64)
    # Create an instance of VnicFcQueueSettings
    tx_queue_settings = VnicFcQueueSettings(ring_size=64)
    # VnicFcAdapterPolicy | The 'VnicFcAdapter.Policy' resource to create.
    fc_adap_pol = VnicFcAdapterPolicy(name="sample_fiber_channel_adapter_policy",
                                      organization=organization,
                                      error_detection_timeout=2000,
                                      io_throttle_count=512,
                                      lun_count=1024,
                                      lun_queue_depth=20,
                                      resource_allocation_timeout=10000,
                                      error_recovery_settings=error_recovery_settings,
                                      flogi_settings=flogi_settings,
                                      interrupt_settings=interrupt_settings,
                                      plogi_settings=plogi_settings,
                                      rx_queue_settings=rx_queue_settings,
                                      scsi_queue_settings=scsi_queue_settings,
                                      tx_queue_settings=tx_queue_settings)
    try:
        # Create a 'VnicFcAdapter.Policy' resource.
        api_response = api_instance.create_vnic_fc_adapter_policy(fc_adap_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_fc_adapter_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of fiber channel adapter policy
    create_fiber_channel_adapter_policy()
