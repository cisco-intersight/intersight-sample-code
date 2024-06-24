import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import fabric_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_eth_network_group_policy import FabricEthNetworkGroupPolicy
from intersight.model.fabric_vlan_settings import FabricVlanSettings

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_ethernet_network_group_policy():
     # Create an instance of the API class.
    api_instance = fabric_api.FabricApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create instance of FabricVlanSettings 
    vlan_settings = FabricVlanSettings(native_vlan=1, allowed_vlans="11,12,13")

    # FabricEthNetworkGroupPolicy | The 'FabricEthNetworkGroup.Policy' resource to create.
    fabric_eth_network_group_policy = FabricEthNetworkGroupPolicy(name="sample_fabricEthNetorkPolicy",
                                                                  organization=organization,
                                                                  vlan_settings=vlan_settings)
    try:
        # Create a 'FabricEthNetworkGroup.Policy' resource.
        api_response = api_instance.create_fabric_eth_network_group_policy(fabric_eth_network_group_policy)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_fabric_eth_network_group_policy: %s\n" % e)
        sys.exit(1)

if __name__ == "__main__":
    # Trigger creation of ethernet network group policy
    create_ethernet_network_group_policy()