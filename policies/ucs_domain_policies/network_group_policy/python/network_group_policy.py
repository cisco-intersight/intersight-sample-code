from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_eth_network_group_policy import FabricEthNetworkGroupPolicy
from intersight.model.fabric_vlan_settings import FabricVlanSettings
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


def create_eth_network_group_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization and vlan settings.
    organization = create_organization()
    vlan_settings = FabricVlanSettings(allowed_vlans="313,314,1000",
                                       native_vlan=1)

    # FabricEthNetworkGroupPolicy | The 'fabric.EthNetworkGroupPolicy' resource to create.
    eth_nw_grp_policy = FabricEthNetworkGroupPolicy()

    # Setting all the attributes for eth_nw_grp_policy instance.
    eth_nw_grp_policy.name = "sample_eth_nw_grp_policy1"
    eth_nw_grp_policy.description = "sample ethernet network group policy."
    eth_nw_grp_policy.organization = organization
    eth_nw_grp_policy.vlan_settings = vlan_settings


    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.EthNetworkGroupPolicy' resource.
        resp_eth_nw_grp_policy = api_instance.create_fabric_eth_network_group_policy(eth_nw_grp_policy)
        pprint(resp_eth_nw_grp_policy)
        return resp_eth_nw_grp_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_eth_network_group_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ethernet network group policy
    create_eth_network_group_policy()