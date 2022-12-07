from authentication.python.intersight_authentication import client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vmedia_policy import VmediaPolicy
from intersight.model.vmedia_mapping import VmediaMapping
from intersight.api import vmedia_api
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


def create_vmedia_policy():
    api_instance = vmedia_api.VmediaApi(api_client)

    # Create an instance of organization and virtual media.
    organization = create_organization()
    vmedia = VmediaMapping(authentication_protocol="none",
                           device_type="hdd",
                           mount_protocol="nfs",
                           volume_name="sample_vol",
                           remote_file="sample_file.img")

    # VmediaPolicy | The 'vmedia.Policy' resource to create.
    vmedia_policy = VmediaPolicy()

    # Setting all the attributes for vmedia_policy instance.
    vmedia_policy.name = "sample_vmedia_policy1"
    vmedia_policy.description = "sample virtual media policy."
    vmedia_policy.organization = organization
    vmedia_policy.low_power_usb = False
    vmedia_policy.mappings = [vmedia]

    try:
        # Create a 'vmedia.Policy' resource.
        resp_vmedia_policy = api_instance.create_vmedia_policy(vmedia_policy)
        pprint(resp_vmedia_policy)
        return resp_vmedia_policy
    except intersight.ApiException as e:
        print("Exception when calling VmediaApi->create_vmedia_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of virtual media policy
    create_vmedia_policy()