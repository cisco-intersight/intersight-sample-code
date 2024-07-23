from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.macpool_block import MacpoolBlock
from intersight.model.macpool_pool import MacpoolPool
from intersight.api import macpool_api, organization_api

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


def create_mac_pool():
    api_instance = macpool_api.MacpoolApi(api_client)

    # Create an instance of organization and mac pool block
    organization = get_organization()
    mac_pool_block = MacpoolBlock(_from="00:25:B5:00:00:01",
                                  size=10)

    # MacpoolPool | The 'macpool.Pool' resource to create.
    mac_pool = MacpoolPool(name="sample_mac_pool_1",
                           assignment_order="sequential",
                           mac_blocks=[mac_pool_block],
                           organization=organization)

    try:
        # Create a 'macpool.Pool' resource.
        resp_macpool = api_instance.create_macpool_pool(mac_pool)
        pprint(resp_macpool)
        return resp_macpool
    except intersight.ApiException as e:
        print("Exception when calling MacpoolApi->create_macpool_pool: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of mac pool
    create_mac_pool()