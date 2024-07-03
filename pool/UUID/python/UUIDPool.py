from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.uuidpool_uuid_block import UuidpoolUuidBlock
from intersight.model.uuidpool_pool import UuidpoolPool
from intersight.api import uuidpool_api, organization_api

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


def create_uuid_pool():
    api_instance = uuidpool_api.UuidpoolApi(api_client)

    # Create an instance of organization and uuid suffix block
    organization = create_organization()
    uuid_suffix_block = UuidpoolUuidBlock(_from="0000-001234500A00",
                                          size=100)

    # UuidpoolPool | The 'uuidpool.Pool' resource to create.
    uuid_pool = UuidpoolPool(name="sample_uuid_pool_1",
                             prefix="00000000-0000-00A0",
                             uuid_suffix_blocks=[uuid_suffix_block],
                             assignment_order="default",
                             organization=organization)

    try:
        # Create a 'uuidpool.Pool' resource.
        resp_uuidpool = api_instance.create_uuidpool_pool(uuid_pool)
        pprint(resp_uuidpool)
        return resp_uuidpool
    except intersight.ApiException as e:
        print("Exception when calling UuidpoolApi->create_uuidpool_pool: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of uuid pool
    create_uuid_pool()