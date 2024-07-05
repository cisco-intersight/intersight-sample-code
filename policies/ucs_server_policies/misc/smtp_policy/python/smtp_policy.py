import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.api import smtp_api, organization_api
from intersight.model.smtp_policy import SmtpPolicy

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

def create_smtp_policy():
    # Create an instance of the API class.
    api_instance = smtp_api.SmtpApi(api_client)
    # Create an instance of organization.
    organization = get_organization()
    # SmtpPolicy | The 'Smtp.Policy' resource to create.
    smtp_pol = SmtpPolicy(name="sample_smtp",
                          smtp_server="samplesmtp.intersight.com",
                          organization=organization,
                          min_severity="critical",
                          enabled=True,
                          smtp_port=25,
                          smtp_recipients=["xyz@test.com"])
    try:
        # Create a 'Smtp.Policy' resource.
        api_response = api_instance.create_smtp_policy(smtp_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling SmtpApi->create_smtp_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of smtp policy
    create_smtp_policy()
