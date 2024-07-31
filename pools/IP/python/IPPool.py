from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.ippool_ip_v4_config import IppoolIpV4Config
from intersight.model.ippool_ip_v4_block import IppoolIpV4Block
from intersight.model.ippool_pool import IppoolPool
from intersight.api import ippool_api, organization_api

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


def create_ip_pool():
    api_instance = ippool_api.IppoolApi(api_client)

    # Create an instance of organization, ipv4config and ipv4block
    organization = get_organization()
    ipv4_config = IppoolIpV4Config(gateway="10.108.190.1",
                                   netmask="255.255.255.0",
                                   primary_dns="10.108.190.100")
    ipv4_block =  IppoolIpV4Block(_from="10.108.190.11",
                                  to="10.108.190.20")

    # IppoolPool | The 'ippool.Pool' resource to create.
    ip_pool = IppoolPool(name="sample_ippool_1",
                         ip_v4_blocks=[ipv4_block],
                         ip_v4_config=ipv4_config,
                         organization=organization)

    try:
        # Create a 'ippool.Pool' resource.
        resp_ippool = api_instance.create_ippool_pool(ip_pool)
        pprint(resp_ippool)
        return resp_ippool
    except intersight.ApiException as e:
        print("Exception when calling IppoolApi->create_ippool_pool: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ip pool
    create_ip_pool()