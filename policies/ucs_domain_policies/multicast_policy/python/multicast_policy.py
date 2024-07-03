from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_multicast_policy import FabricMulticastPolicy
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

def create_multicast_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # FabricMulticastPolicy | The 'fabric.MulticastPolicy' resource to create.
    multicast_policy = FabricMulticastPolicy()

    # Setting all the attributes for multicast_policy instance.
    multicast_policy.name = "sample_multicast_policy1"
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


if __name__ == "__main__":
    # Trigger creation of multicast policy
    create_multicast_policy()