from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.networkconfig_policy import NetworkconfigPolicy
from intersight.api import networkconfig_api, organization_api
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


def create_network_conn_policy():
    api_instance = networkconfig_api.NetworkconfigApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # NetworkconfigPolicy | The 'networkconfig.Policy' resource to create.
    nw_conn_policy = NetworkconfigPolicy()

    # Setting attributes for nw_conn_policy instance.
    nw_conn_policy.name = "sample_nw_conn_policy1"
    nw_conn_policy.description = "sample network connectivity policy."
    nw_conn_policy.organization = organization
    nw_conn_policy.dynamic_dns_domain = "cisco.com"
    nw_conn_policy.preferred_ipv4dns_server = "8.8.8.8"
    nw_conn_policy.alternate_ipv4dns_server = "22.22.22.22"
    nw_conn_policy.enable_dynamic_dns =True
    nw_conn_policy.enable_ipv6 = True

    try:
        # Create a 'networkconfig.Policy' resource.
        resp_nw_conn_policy = api_instance.create_networkconfig_policy(nw_conn_policy)
        pprint(resp_nw_conn_policy)
        return resp_nw_conn_policy
    except intersight.ApiException as e:
        print("Exception when calling BiosApi->create_bios_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of network connectivity policy
    create_network_conn_policy()