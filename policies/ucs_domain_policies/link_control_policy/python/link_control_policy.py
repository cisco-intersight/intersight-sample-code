from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_link_control_policy import FabricLinkControlPolicy
from intersight.model.fabric_udld_settings import FabricUdldSettings
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

def create_link_control_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization and udld settings.
    organization = create_organization()
    udld_settings = FabricUdldSettings(admin_state="Enabled",
                                       mode="normal")

    # FabricLinkControlPolicy | The 'fabric.LinkControlPolicy' resource to create.
    link_control_policy = FabricLinkControlPolicy()

    # Setting all the attributes for link_control_policy instance.
    link_control_policy.name = "sample_link_control_policy1"
    link_control_policy.description = "sample link control policy."
    link_control_policy.organization = organization
    link_control_policy.udld_settings = udld_settings


    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.LinkControlPolicy' resource.
        resp_link_control_policy = api_instance.create_fabric_link_control_policy(link_control_policy)
        pprint(resp_link_control_policy)
        return resp_link_control_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_link_control_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of link control policy
    create_link_control_policy()