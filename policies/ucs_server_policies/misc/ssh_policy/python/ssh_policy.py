import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.api import ssh_api, organization_api
from intersight.model.ssh_policy import SshPolicy

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

def create_ssh_policy():
    # Create an instance of the API class.
    api_instance = ssh_api.SshApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # SshPolicy | The 'Ssh.Policy' resource to create.
    ssh_pol = SshPolicy(name="sample_ssh_policy",
                        description="ssh policy",
                        port=12000,
                        timeout=1800,
                        organization=organization)
    try:
        # Create a 'Ssh.Policy' resource.
        api_response = api_instance.create_ssh_policy(ssh_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling SshApi->create_ssh_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ssh policy
    create_ssh_policy()
