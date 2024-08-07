from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.ipmioverlan_policy import IpmioverlanPolicy
from intersight.api import ipmioverlan_api, organization_api
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


def create_ipmi_over_lan_policy():
    api_instance = ipmioverlan_api.IpmioverlanApi(api_client)

    # Create an instance of organization.
    organization = get_organization()

    # IpmioverlanPolicy | The 'ipmioverlan.Policy' resource to create.
    ipmiol_policy = IpmioverlanPolicy()

    # Setting all the attributes for ipmiol_policy instance.
    ipmiol_policy.name = "sample_ipmi_over_lan_policy1"
    ipmiol_policy.description = "sample ipmi over lan policy."
    ipmiol_policy.organization = organization
    ipmiol_policy.privilege = "admin"
    ipmiol_policy.encryption_key = "FFFFAAAA99990000"
    ipmiol_policy.enabled = True

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'ipmioverlan.Policy' resource.
        resp_ipmiol_policy = api_instance.create_ipmioverlan_policy(ipmiol_policy)
        pprint(resp_ipmiol_policy)
        return resp_ipmiol_policy
    except intersight.ApiException as e:
        print("Exception when calling IpmioverlanApi->create_ipmi_over_lan_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ipmi over lan policy
    create_ipmi_over_lan_policy()