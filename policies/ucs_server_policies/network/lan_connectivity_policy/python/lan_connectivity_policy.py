import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_lan_connectivity_policy import VnicLanConnectivityPolicy
from intersight.model.vnic_eth_if_relationship import VnicEthIfRelationship

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_lan_connectivity_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Get references to  VnicEthIf object
    eth_if_ref1= VnicEthIfRelationship(class_id="mo.MoRef", object_type="vnic.EthIf", moid="moid_of_ethif")
    eth_if_ref2= VnicEthIfRelationship(class_id="mo.MoRef", object_type="vnic.EthIf", moid="moid_of_ethif")

    # Create lan connectivity policy
    vnic_lan_con_pol1 = VnicLanConnectivityPolicy(name="sample_lan_policy1",
                                                  organization=organization,
                                                  iqn_allocation_type="None",
                                                  placement_mode="custom",
                                                  target_platform="Standalone",
                                                  azure_qos_enabled=True,
                                                  eth_ifs=[eth_if_ref1, eth_if_ref2])
    try:
        # Create a 'VnicLanConnectivity.Policy' resource.
        api_response1 = api_instance.create_vnic_lan_connectivity_policy(vnic_lan_con_pol1)
        print(api_response1)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_lan_connectivity_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of lan connectivity policy
    create_lan_connectivity_policy()
