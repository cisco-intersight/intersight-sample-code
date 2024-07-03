import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import ntp_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.ntp_policy import NtpPolicy

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

def create_ntp_policy():
    # Create an instance of the API class.
    api_instance = ntp_api.NtpApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # NtpPolicy | The 'Ntp.Policy' resource to create.
    ntp_pol = NtpPolicy(name="sample_ntp_policy",
                        ntp_servers=["1.1.1.1"],
                        enabled=True,
                        timezone="Indian/Mauritius",
                        organization=organization)
    try:
        # Create a 'Ntp.Policy' resource.
        api_response = api_instance.create_ntp_policy(ntp_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling NtpApi->create_ntp_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ntp policy
    create_ntp_policy()
