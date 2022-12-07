from authentication.python.intersight_authentication import client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.kvm_policy import KvmPolicy
from intersight.api import kvm_api
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