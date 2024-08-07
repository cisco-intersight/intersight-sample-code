from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.power_policy import PowerPolicy
from intersight.api import power_api, organization_api
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


def create_power_policy():
    api_instance = power_api.PowerApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # PowerPolicy | The 'power.Policy' resource to create.
    power_policy = PowerPolicy()

    # Setting all the attributes for power_policy instance.
    power_policy.name = "sample_power_policy1"
    power_policy.description = "sample power policy."
    power_policy.organization = organization
    power_policy.dynamic_rebalancing = "Enabled"
    power_policy.extended_power_capacity = "Enabled"
    power_policy.power_priority = "High"
    power_policy.power_profiling = "Enabled"
    power_policy.power_restore_state = "AlwaysOff"
    power_policy.power_save_mode = "Enabled"
    power_policy.redundancy_mode = "Grid"

    try:
        # Create a 'power.Policy' resource.
        resp_power_policy = api_instance.create_power_policy(power_policy)
        pprint(resp_power_policy)
        return resp_power_policy
    except intersight.ApiException as e:
        print("Exception when calling PowerApi->create_power_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of power policy
    create_power_policy()