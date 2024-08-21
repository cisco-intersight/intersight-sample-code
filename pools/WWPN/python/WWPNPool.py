from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fcpool_block import FcpoolBlock
from intersight.model.fcpool_pool import FcpoolPool
from intersight.api import fcpool_api, organization_api

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


def create_wwpn_pool():
    api_instance = fcpool_api.FcpoolApi(api_client)

    # Create an instance of organization and fc pool block
    organization = get_organization()
    fc_pool_block = FcpoolBlock(_from="20:00:00:25:B5:00:00:01",
                                size=100)

    # FcpoolPool | The 'fcpool.Pool' resource to create.
    wwpn_pool = FcpoolPool(name="sample_wwpn_pool_1",
                         assignment_order="default",
                         id_blocks=[fc_pool_block],
                         pool_purpose="WWPN",
                         organization=organization)

    try:
        # Create a 'fcpool.Pool' resource.
        resp_wwpnpool = api_instance.create_fcpool_pool(wwpn_pool)
        pprint(resp_wwpnpool)
        return resp_wwpnpool
    except intersight.ApiException as e:
        print("Exception when calling FcpoolBlock->create_fcpool_pool: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of wwpn pool
    create_wwpn_pool()