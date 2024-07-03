from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_port_policy import FabricPortPolicy
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


def create_port_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # FabricPortPolicy | The 'fabric.PortPolicy' resource to create.
    port_policy = FabricPortPolicy()

    # Setting all the attributes for port_policy instance.
    port_policy.name = "sample_port_policy1"
    port_policy.description = "sample port policy."
    port_policy.organization = organization
    port_policy.device_model = "UCS-FI-6454"

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.PortPolicy' resource.
        resp_port_policy = api_instance.create_fabric_port_policy(port_policy)
        pprint(resp_port_policy)
        return resp_port_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_port_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of port policy
    create_port_policy()