from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.iqnpool_iqn_suffix_block import IqnpoolIqnSuffixBlock
from intersight.model.iqnpool_pool import IqnpoolPool
from intersight.api import iqnpool_api, organization_api

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


def create_iqn_pool():
    api_instance = iqnpool_api.IqnpoolApi(api_client)

    # Create an instance of organization and iqn suffix block
    organization = get_organization()
    iqn_suffix_block = IqnpoolIqnSuffixBlock(suffix="iscsi01",
                                             _from=0,
                                             to=9)

    # IqnpoolPool | The 'iqnpool.Pool' resource to create.
    iqn_pool = IqnpoolPool(name="sample_iqn_pool_1",
                           prefix="iqn.2023-06.abc.com",
                           iqn_suffix_blocks=[iqn_suffix_block],
                           organization=organization)

    try:
        # Create a 'iqnpool.Pool' resource.
        resp_iqnpool = api_instance.create_iqnpool_pool(iqn_pool)
        pprint(resp_iqnpool)
        return resp_iqnpool
    except intersight.ApiException as e:
        print("Exception when calling IqnpoolApi->create_iqnpool_pool: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of iqn pool
    create_iqn_pool()