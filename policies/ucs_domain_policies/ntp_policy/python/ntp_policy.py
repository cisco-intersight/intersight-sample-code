from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.ntp_policy import NtpPolicy
from intersight.api import ntp_api, organization_api
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


def create_ntp_policy():
    api_instance = ntp_api.NtpApi(api_client)

    # Create an instance of organization and list of ntp servers.
    organization = get_organization()
    ntp_servers = [
        "10.10.10.250", "10.10.10.10", "10.10.10.20", "10.10.10.30"
    ]

    # NtpPolicy | The 'ntp.Policy' resource to create.
    ntp_policy = NtpPolicy()

    # Setting all the attributes for ntp_policy instance.
    ntp_policy.name = "sample_ntp_policy1"
    ntp_policy.description = "sample ntp policy."
    ntp_policy.enabled = True
    ntp_policy.organization = organization
    ntp_policy.ntp_servers = ntp_servers

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'ntp.Policy' resource.
        resp_ntp_policy = api_instance.create_ntp_policy(ntp_policy)
        pprint(resp_ntp_policy)
        return resp_ntp_policy
    except intersight.ApiException as e:
        print("Exception when calling NtpApi->create_ntp_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ntp policy
    create_ntp_policy()