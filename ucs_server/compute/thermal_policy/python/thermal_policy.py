from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.thermal_policy import ThermalPolicy
from intersight.api import thermal_api, organization_api
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



def create_thermal_policy():
    api_instance = thermal_api.ThermalApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # ThermalPolicy | The 'thermal.Policy' resource to create.
    thermal_policy = ThermalPolicy()

    # Setting attributes for thermal_policy instance.
    thermal_policy.name = "sample_thermal_policy"
    thermal_policy.fan_control_mode = "Balanced"
    thermal_policy.organization = organization

    try:
        # Create a 'thermal.Policy' resource.
        resp_thermal_policy = api_instance.create_thermal_policy(thermal_policy)
        pprint(resp_thermal_policy)
        return resp_thermal_policy
    except intersight.ApiException as e:
        print("Exception when calling ThermalApi->create_thermal_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of thermal policy
    create_thermal_policy()