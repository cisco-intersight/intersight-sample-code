from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_eth_network_policy import FabricEthNetworkPolicy
from intersight.model.fabric_multicast_policy import FabricMulticastPolicy
from intersight.model.fabric_eth_network_policy_relationship import FabricEthNetworkPolicyRelationship
from intersight.model.fabric_multicast_policy_relationship import FabricMulticastPolicyRelationship
from intersight.model.fabric_vlan import FabricVlan
from intersight.api import fabric_api, organization_api
import intersight

from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def get_organization(organization_name = 'default'):
    # Get the organization and return OrganizationRelationship
    api_instance = organization_api.OrganizationApi(api_client)
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


def create_network_policy_reference(network_policy_moid):
    return FabricEthNetworkPolicyRelationship(class_id="mo.MoRef",
                                              moid=network_policy_moid,
                                              object_type="fabric.EthNetworkPolicy")


def create_multicast_policy_reference(multicast_policy_moid):
    return FabricMulticastPolicyRelationship(class_id="mo.MoRef",
                                             moid=multicast_policy_moid,
                                             object_type="fabric.MulticastPolicy")


def create_network_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # FabricEthNetworkPolicy | The 'fabric.EthNetworkPolicy' resource to create.
    network_policy = FabricEthNetworkPolicy()

    # Setting all the attributes for network_policy instance.
    network_policy.name = "sample_network_policy1"
    network_policy.description = "sample network policy."
    network_policy.organization = organization

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.EthNetworkPolicy' resource.
        resp_network_policy = api_instance.create_fabric_eth_network_policy(network_policy)
        pprint(resp_network_policy)
        return resp_network_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_network_policy: %s\n" % e)
        sys.exit(1)


def create_multicast_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # FabricMulticastPolicy | The 'fabric.MulticastPolicy' resource to create.
    multicast_policy = FabricMulticastPolicy()

    # Setting all the attributes for multicast_policy instance.
    multicast_policy.name = "sample_multicast_policy"
    multicast_policy.description = "sample multicast policy."
    multicast_policy.organization = organization
    multicast_policy.snooping_state = "Enabled"
    multicast_policy.querier_state = "Enabled"
    multicast_policy.querier_ip_address = "1.1.1.1"


    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.MulticastPolicy' resource.
        resp_multicast_policy = api_instance.create_fabric_multicast_policy(multicast_policy)
        pprint(resp_multicast_policy)
        return resp_multicast_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_multicast_policy: %s\n" % e)
        sys.exit(1)


def create_vlan(network_policy_moid, multicast_policy_moid):
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # FabricVlan | The 'fabric.Vlan' resource to create.
    vlan = FabricVlan()

    # Setting attributes for the vlan.
    vlan.name = "sample_vlan"
    vlan.vlan_id = 2222
    vlan.eth_network_policy = create_network_policy_reference(network_policy_moid)
    vlan.multicast_policy = create_multicast_policy_reference(multicast_policy_moid)
    vlan.auto_allow_on_uplinks = False
    vlan.is_native = False
    vlan.vlan_id = 23

    try:
        # Create a 'fabric.Vlan' resource.
        resp_vlan = api_instance.create_fabric_vlan(vlan)
        pprint(resp_vlan)
        return resp_vlan
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_vlan: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of network policy
    network_policy_response = create_network_policy()

    # Finding out network policy moid
    network_policy_moid = network_policy_response.moid

    # Trigger creation of multicast policy
    multicast_policy_response = create_multicast_policy()

    # Finding out multicast policy moid
    multicast_policy_moid = multicast_policy_response.moid

    # Create a vlan and attach the network and multicast policies
    create_vlan(network_policy_moid, multicast_policy_moid)