from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_flow_control_policy import FabricFlowControlPolicy
from intersight.api import fabric_api, organization_api
import intersight

from pprint import pprint
import sys


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

def create_flow_control_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # FabricFlowControlPolicy | The 'fabric.FlowControlPolicy' resource to create.
    flow_control_policy = FabricFlowControlPolicy()

    # Setting all the attributes for flow_control_policy instance.
    flow_control_policy.name = "sample_flow_control_policy1"
    flow_control_policy.description = "sample flow control policy."
    flow_control_policy.organization = organization
    flow_control_policy.priority_flow_control_mode = "auto"
    flow_control_policy.receive_direction = "Disabled"
    flow_control_policy.send_direction = "Disabled"

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.FlowControlPolicy' resource.
        resp_flow_control_policy = api_instance.create_fabric_flow_control_policy(flow_control_policy)
        pprint(resp_flow_control_policy)
        return resp_flow_control_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_flow_control_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of flow control policy
    create_flow_control_policy()