from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vmedia_policy import VmediaPolicy
from intersight.model.vmedia_mapping import VmediaMapping
from intersight.api import vmedia_api, organization_api
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


def create_vmedia_policy():
    api_instance = vmedia_api.VmediaApi(api_client)

    # Create an instance of organization and virtual media.
    organization = create_organization()
    vmedia = VmediaMapping(authentication_protocol="none",
                           device_type="cdd",
                           file_location="nfs://10.193.167.6/exports/vms/ucs-c240m5-huu-3.1.3h.iso",
                           host_name="12.11.11.13",
                           mount_protocol="nfs",
                           volume_name="sample_vol",
                           remote_file="sample_file.img")

    # VmediaPolicy | The 'vmedia.Policy' resource to create.
    vmedia_policy = VmediaPolicy()

    # Setting all the attributes for vmedia_policy instance.
    vmedia_policy.name = "sample_vmedia_policy1"
    vmedia_policy.description = "sample virtual media policy."
    vmedia_policy.organization = organization
    vmedia_policy.low_power_usb = True
    vmedia_policy.enabled = True
    vmedia_policy.encryption = True
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