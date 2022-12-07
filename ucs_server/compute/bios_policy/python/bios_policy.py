from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.bios_policy import BiosPolicy
from intersight.api import bios_api
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


def create_bios_policy():
    api_instance = bios_api.BiosApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # BiosPolicy | The 'bios.Policy' resource to create.
    bios_policy = BiosPolicy()

    # Setting attributes for bios_policy instance.
    bios_policy.name = "sample_bios_policy1"
    bios_policy.description = "sample bios policy."
    bios_policy.organization = organization
    bios_policy.advanced_mem_test = "Auto"
    bios_policy.all_usb_devices = "enabled"
    bios_policy.bme_dma_mitigation = "enabled"
    bios_policy.boot_option_retry = "enabled"
    bios_policy.core_multi_processing = "4"
    bios_policy.cpu_power_management = "energy-efficient"

    try:
        # Create a 'bios.Policy' resource.
        resp_bios_policy = api_instance.create_bios_policy(bios_policy)
        pprint(resp_bios_policy)
        return resp_bios_policy
    except intersight.ApiException as e:
        print("Exception when calling BiosApi->create_bios_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of bios policy
    create_bios_policy()