from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.resourcepool_server_pool_parameters import ResourcepoolServerPoolParameters
from intersight.model.resource_selector import ResourceSelector
from intersight.model.resourcepool_pool import ResourcepoolPool
from intersight.api import resourcepool_api, organization_api

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


def create_resource_pool():
    api_instance = resourcepool_api.ResourcepoolApi(api_client)

    # Create an instance of organization, resource pool parameters and resource selector
    organization = get_organization()
    resource_pool_parameter = ResourcepoolServerPoolParameters(management_mode="IntersightStandalone")
    resource_selector = ResourceSelector(selector="/api/v1/compute/RackUnits?$filter=(Serial eq 'WZP22340VWC')")

    # ResourcepoolPool | The 'resourcepool.Pool' resource to create.
    resource_pool = ResourcepoolPool(name="sample_resource_pool_1",
                                     assignment_order="sequential",
                                     pool_type="Static",
                                     resource_pool_parameters=resource_pool_parameter,
                                     selectors=[resource_selector],
                                     organization=organization)

    try:
        # Create a 'resourcepool.Pool' resource.
        resp_resourcepool = api_instance.create_resourcepool_pool(resource_pool)
        pprint(resp_resourcepool)
        return resp_resourcepool
    except intersight.ApiException as e:
        print("Exception when calling ResourcepoolApi->create_resourcepool_pool: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of resource pool
    create_resource_pool()