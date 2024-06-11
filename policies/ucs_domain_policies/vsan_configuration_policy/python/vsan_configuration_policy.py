from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_fc_network_policy import FabricFcNetworkPolicy
from intersight.model.fabric_fc_network_policy_relationship import FabricFcNetworkPolicyRelationship
from intersight.model.fabric_vsan import FabricVsan
from intersight.api import fabric_api
import intersight

from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization")

def create_vsan_policy_reference(vsan_policy_moid):
    return FabricFcNetworkPolicyRelationship(class_id="mo.MoRef",
                                              moid=vsan_policy_moid,
                                              object_type="fabric.FcNetworkPolicy")

def create_vsan_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # FabricFcNetworkPolicy | The 'fabric.FcNetworkPolicy' resource to create.
    vsan_policy = FabricFcNetworkPolicy()

    # Setting all the attributes for vsan_policy instance.
    vsan_policy.name = "sample_vsan_policy1"
    vsan_policy.description = "sample vsan policy."
    vsan_policy.organization = organization

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.FcNetworkPolicy' resource.
        resp_vsan_policy = api_instance.create_fabric_fc_network_policy(vsan_policy)
        pprint(resp_vsan_policy)
        return resp_vsan_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_vsan_policy: %s\n" % e)
        sys.exit(1)

def create_vsan(vsan_policy_moid):
    api_instance = fabric_api.FabricApi(api_client)

    # FabricVsan | The 'fabric.Vsan' resource to create.
    vsan = FabricVsan()

    # Setting all the attributes for vsan instance.
    vsan.name = "sample_vsan1"
    vsan.default_zoning = "Enabled"
    vsan.vsan_scope = "Common"
    vsan.fcoe_vlan = 444
    vsan.vsan_id = 333
    vsan.fc_network_policy = create_vsan_policy_reference(vsan_policy_moid)

    try:
        # Create a 'fabric.Vsan' resource.
        resp_vsan = api_instance.create_fabric_vsan(vsan)
        pprint(resp_vsan)
        return resp_vsan
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create: %s\n" % e)
        sys.exit(1)

if __name__ == "__main__":
    # Trigger creation of vsan policy
    vsan_policy_response = create_vsan_policy()

    # Finding out vsan policy moid
    vsan_policy_moid = vsan_policy_response.moid

    # Create a vsan and attach the policy
    create_vsan(vsan_policy_moid)