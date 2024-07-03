import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import fabric_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_eth_network_control_policy import FabricEthNetworkControlPolicy
from intersight.model.fabric_lldp_settings import FabricLldpSettings

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


def create_network_control_policy():
    # Create an instance of the API class.
    api_instance = fabric_api.FabricApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create instance of FabricLldpSettings
    lldp_settings = FabricLldpSettings(receive_enabled=True, transmit_enabled=True)

    # FabricEthNetworkControlPolicy | The 'FabricEthNetworkControl.Policy' resource to create.
    fabric_eth_network_control_policy = FabricEthNetworkControlPolicy(name="sample_eth_network_control_policy_1",
                                                                      organization=organization,
                                                                      forge_mac="allow",
                                                                      mac_registration_mode="nativeVlanOnly",
                                                                      cdp_enabled=True,
                                                                      uplink_fail_action="linkDown",
                                                                      lldp_settings=lldp_settings)
    try:
        # Create a 'FabricEthNetworkControl.Policy' resource.
        api_response = api_instance.create_fabric_eth_network_control_policy(fabric_eth_network_control_policy)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_fabric_eth_network_control_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ethernet adapter policy
    create_network_control_policy()