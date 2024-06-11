from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.access_policy import AccessPolicy
from intersight.model.ippool_pool import IppoolPool
from intersight.model.ippool_ip_v4_block import IppoolIpV4Block
from intersight.model.ippool_ip_v4_config import IppoolIpV4Config
from intersight.model.ippool_pool_relationship import IppoolPoolRelationship
from intersight.api import access_api, ippool_api
import intersight

from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization")


def create_ippool_pool_reference(ippool_pool_moid):
    return IppoolPoolRelationship(class_id="mo.MoRef",
                                              moid=ippool_pool_moid,
                                              object_type="ippool.Pool")

def create_ippool_pool():
    api_instance = ippool_api.IppoolApi(api_client)

    # Create an instance of organization, ipv4 block and ipv4 configuration.
    organization = create_organization()
    ipv4_block = IppoolIpV4Block(class_id="ippool.IpV4Block",
                                 _from="192.168.0.2",
                                 size=32)
    ipv4_config = IppoolIpV4Config(class_id="ippool.IpV4Config",
                                   gateway="192.168.0.1",
                                   netmask="255.255.255.0")

    # IppoolPool | The 'ippool.Pool' resource to create.
    ip_pool = IppoolPool()

    # Setting all the attributes for ip_pool instance.
    ip_pool.name = "sample_ip_pool1"
    ip_pool.description = "sample ip pool."
    ip_pool.organization = organization
    ip_pool.assignment_order = "sequential"
    ip_pool.ip_v4_blocks = [ipv4_block]
    ip_pool.ip_v4_config = ipv4_config

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'ippool.Pool' resource.
        resp_ip_pool = api_instance.create_ippool_pool(ip_pool)
        pprint(resp_ip_pool)
        return resp_ip_pool
    except intersight.ApiException as e:
        print("Exception when calling IppoolPool->create_ippool_pool: %s\n" % e)
        sys.exit(1)


def create_access_policy(ippool_pool_moid):
    api_instance = access_api.AccessApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # AccessPolicy | The 'access.Policy' resource to create.
    access_policy = AccessPolicy()

    # Setting all the attributes for access_policy instance.
    access_policy.name = "sample_access_policy1"
    access_policy.description = "sample access policy."
    access_policy.organization = organization
    access_policy.inband_vlan = 333
    access_policy.inband_ip_pool = create_ippool_pool_reference(ippool_pool_moid)

    try:
        # Create a 'access.Policy' resource.
        resp_access_policy = api_instance.create_access_policy(access_policy)
        pprint(resp_access_policy)
        return resp_access_policy
    except intersight.ApiException as e:
        print("Exception when calling AccessApi->create_access_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of an ip pool
    ippool_pool_response = create_ippool_pool()

    # Finding out ip pool moid
    ippool_pool_moid = ippool_pool_response.moid

    # Trigger creation of imc access policy
    create_access_policy(ippool_pool_moid)