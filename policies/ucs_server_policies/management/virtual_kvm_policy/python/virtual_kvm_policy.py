from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.kvm_policy import KvmPolicy
from intersight.api import kvm_api, organization_api
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

def create_kvm_policy():
    api_instance = kvm_api.KvmApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # KvmPolicy | The 'kvm.Policy' resource to create.
    kvm_policy = KvmPolicy()

    # Setting all the attributes for kvm_policy instance.
    kvm_policy.name = "sample_kvm_policy1"
    kvm_policy.description = "sample kvm policy."
    kvm_policy.organization = organization
    kvm_policy.maximum_sessions = 3
    kvm_policy.remote_port = 33333
    kvm_policy.enabled = True
    kvm_policy.enable_video_encryption = True
    kvm_policy.enable_local_server_video = True

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'kvm.Policy' resource.
        resp_kvm_policy = api_instance.create_kvm_policy(kvm_policy)
        pprint(resp_kvm_policy)
        return resp_kvm_policy
    except intersight.ApiException as e:
        print("Exception when calling KvmApi->create_kvm_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of kvm policy
    create_kvm_policy()