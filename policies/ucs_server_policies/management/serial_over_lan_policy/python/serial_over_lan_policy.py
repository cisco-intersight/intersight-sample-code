from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.sol_policy import SolPolicy
from intersight.api import sol_api, organization_api
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


def create_sol_policy():
    api_instance = sol_api.SolApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # SolPolicy | The 'sol.Policy' resource to create.
    sol_policy = SolPolicy()

    # Setting all the attributes for sol_policy instance.
    sol_policy.name = "sample_sol_policy1"
    sol_policy.description = "sample sol policy."
    sol_policy.organization = organization
    sol_policy.baud_rate = 9600
    sol_policy.com_port = "com0"
    sol_policy.ssh_port = 2400
    sol_policy.enabled = True

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'sol.Policy' resource.
        resp_sol_policy = api_instance.create_sol_policy(sol_policy)
        pprint(resp_sol_policy)
        return resp_sol_policy
    except intersight.ApiException as e:
        print("Exception when calling SolApi->create_sol_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of sol policy
    create_sol_policy()