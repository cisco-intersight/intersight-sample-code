from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_eth_network_control_policy import FabricEthNetworkControlPolicy
from intersight.model.fabric_lldp_settings import FabricLldpSettings
from intersight.model.vnic_eth_network_policy_relationship import VnicEthNetworkPolicyRelationship
from intersight.api import fabric_api
import intersight

from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_eth_network_control_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization and lldp setttings.
    organization = create_organization()
    lldp_settings = FabricLldpSettings(receive_enabled=False,
                                       transmit_enabled=False)
    
    # Craete an instance of network_policy
    network_policy = VnicEthNetworkPolicyRelationship(class_id="mo.MoRef",
                                                      object_type="vnic.EthNetworkPolicy",
                                                      moid="moid_of_network_policy")

    # FabricEthNetworkControlPolicy | The 'fabric.EthNetworkControlPolicy' resource to create.
    eth_nw_ctrl_policy = FabricEthNetworkControlPolicy()

    # Setting all the attributes for eth_nw_ctrl_policy instance.
    eth_nw_ctrl_policy.name = "sample_eth_nw_ctrl_policy1"
    eth_nw_ctrl_policy.description = "sample ethernet network control policy."
    eth_nw_ctrl_policy.organization = organization
    eth_nw_ctrl_policy.cdp_enabled = False
    eth_nw_ctrl_policy.mac_registration_mode = "allVlans"
    eth_nw_ctrl_policy.forge_mac = "allow"
    eth_nw_ctrl_policy.uplink_fail_action = "linkDown"
    eth_nw_ctrl_policy.lldp_settings = lldp_settings
    eth_nw_ctrl_policy.network_policy = [network_policy]


    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.EthNetworkControlPolicy' resource.
        resp_eth_nw_ctrl_policy = api_instance.create_fabric_eth_network_control_policy(eth_nw_ctrl_policy)
        pprint(resp_eth_nw_ctrl_policy)
        return resp_eth_nw_ctrl_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_eth_network_control_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ethernet network control policy
    create_eth_network_control_policy()