import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_eth_adapter_policy import VnicEthAdapterPolicy
from intersight.model.vnic_arfs_settings import VnicArfsSettings
from intersight.model.vnic_completion_queue_settings import VnicCompletionQueueSettings
from intersight.model.vnic_eth_interrupt_settings import VnicEthInterruptSettings
from intersight.model.vnic_nvgre_settings import VnicNvgreSettings
from intersight.model.vnic_ptp_settings import VnicPtpSettings
from intersight.model.vnic_roce_settings import VnicRoceSettings
from intersight.model.vnic_rss_hash_settings import VnicRssHashSettings
from intersight.model.vnic_eth_rx_queue_settings import VnicEthRxQueueSettings
from intersight.model.vnic_tcp_offload_settings import VnicTcpOffloadSettings
from intersight.model.vnic_eth_tx_queue_settings import VnicEthTxQueueSettings
from intersight.model.vnic_vxlan_settings import VnicVxlanSettings

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    api_instance = organization_api.OrganizationApi(api_client)
    organization_name = 'default'
    odata = {"filter":f"Name eq {organization_name}"}
    organizations = api_instance.get_organization_organization_list(**odata)
    if organizations.results and len(organizations.results) > 0:
        moid = organizations.results[0].moid
    else:
        print("No organization was found with given name")
        sys.exit(1)
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid=moid)

def create_ethernet_adapter_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create instance of VnicArfsSettings
    vnic_arfs_settings = VnicArfsSettings(enabled=True)
    # Create instance of VnicCompletionQueueSettings
    completion_queue = VnicCompletionQueueSettings(count=5, ring_size=1)
    # Create instance of VnicEthInterruptSettings
    eth_interrupt_settings = VnicEthInterruptSettings(coalescing_time=125,
                                                  coalescing_type="MIN",
                                                  mode="MSIx",
                                                  count=8)
    # Create instance of VnicNvgreSettings
    nvgre_settings = VnicNvgreSettings(enabled=True)
    # Create instance of VnicPtpSettings
    ptp_settings = VnicPtpSettings(enabled=True)
    # Create instance of VnicRoceSettings
    roce_settings = VnicRoceSettings(class_of_service=5,
                                     enabled=True,
                                     memory_regions=131072,
                                     queue_pairs=256,
                                     resource_groups=4,
                                     version=1)
    # Create instance of VnicRssHashSettings
    rss_hash_settings = VnicRssHashSettings(ipv4_hash=True,
                                            tcp_ipv4_hash=True)
    # Create instance of VnicEthRxQueueSettings
    rx_queue_settings = VnicEthRxQueueSettings(count=4, ring_size=512)
    # Create instance of VnicTcpOffloadSettings
    tcp_offload_settings = VnicTcpOffloadSettings(large_receive=True,
                                                  large_send=True,
                                                  rx_checksum=True,
                                                  tx_checksum=True)
   # Create instance of VnicEthTxQueueSettings
    tx_queue_settings = VnicEthTxQueueSettings(count=1,
                                               ring_size=256)
    # Create instance of VnicVxlanSettings
    vxlan_settings = VnicVxlanSettings(enabled=True)
    
    # VnicEthAdapterPolicy | The 'VnicEthAdapter.Policy' resource to create.
    vnic_eth_adapter_policy = VnicEthAdapterPolicy(name="sample_ethernet_adapter_policy",
                                                   organization=organization,
                                                   advanced_filter=True,
                                                   arfs_settings=vnic_arfs_settings,
                                                   completion_queue_settings=completion_queue,
                                                   interrupt_settings=eth_interrupt_settings,
                                                   ptp_settings=ptp_settings,
                                                   roce_settings=roce_settings,
                                                   rss_hash_settings=rss_hash_settings,
                                                   rss_settings=True,
                                                   rx_queue_settings=rx_queue_settings,
                                                   tcp_offload_settings=tcp_offload_settings,
                                                   tx_queue_settings=tx_queue_settings,
                                                   vxlan_settings=vxlan_settings)
    try:
        # Create a 'VnicEthAdapter.Policy' resource.
        api_response = api_instance.create_vnic_eth_adapter_policy(vnic_eth_adapter_policy)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_eth_adapter_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ethernet adapter policy
    create_ethernet_adapter_policy()
