from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fcpool_block import FcpoolBlock
from intersight.model.fcpool_pool import FcpoolPool
from intersight.api import fcpool_api

import intersight
from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")


def create_wwnn_pool():
    api_instance = fcpool_api.FcpoolApi(api_client)

    # Create an instance of organization and fc pool block
    organization = create_organization()
    fc_pool_block = FcpoolBlock(_from="20:00:00:25:B5:00:00:01",
                                size=100)

    # FcpoolPool | The 'fcpool.Pool' resource to create.
    wwnn_pool = FcpoolPool(name="sample_wwnn_pool_1",
                         assignment_order="default",
                         id_blocks=[fc_pool_block],
                         pool_purpose="WWNN",
                         organization=organization)

    try:
        # Create a 'fcpool.Pool' resource.
        resp_wwnnpool = api_instance.create_fcpool_pool(wwnn_pool)
        pprint(resp_wwnnpool)
        return resp_wwnnpool
    except intersight.ApiException as e:
        print("Exception when calling FcpoolBlock->create_fcpool_pool: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of wwnn pool
    create_wwnn_pool()