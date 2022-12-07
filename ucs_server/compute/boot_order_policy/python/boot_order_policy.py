from authentication.python.intersight_authentication import client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.boot_precision_policy import BootPrecisionPolicy
from intersight.model.boot_device_base import BootDeviceBase
from intersight.model.bios_policy import BiosPolicy
from intersight.api import boot_api
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


def create_boot_local_cdd():
    # Creating an instance of boot_local_cdd
    boot_local_cdd = BootDeviceBase(class_id="boot.LocalCdd",
                                    object_type="boot.LocalCdd",
                                    name="local_cdd1",
                                    enabled=True)
    return boot_local_cdd


def create_boot_local_disk():
    # Creating an instance of boot_local_disk
    boot_local_disk = BootDeviceBase(class_id="boot.LocalDisk",
                                     object_type="boot.LocalDisk",
                                     name="local_disk1",
                                     enabled=True)
    return boot_local_disk


def create_boot_precision_policy():
    api_instance = boot_api.BootApi(api_client)

    # Create an instance of local_cdd, local_disk, organization and list of boot_devices.
    boot_local_cdd = create_boot_local_cdd()
    boot_local_disk = create_boot_local_disk()
    organization = create_organization()
    boot_devices = [
        boot_local_disk,
        boot_local_cdd,
    ]

    # BootPrecisionPolicy | The 'boot.PrecisionPolicy' resource to create.
    boot_precision_policy = BootPrecisionPolicy()

    # Setting all the attributes for boot_precison_policy instance.
    boot_precision_policy.name = "sample_boot_policy1"
    boot_precision_policy.description = "sample boot precision policy"
    boot_precision_policy.boot_devices = boot_devices
    boot_precision_policy.organization = organization

    try:
        # Create a 'boot.PrecisionPolicy' resource.
        resp_boot_precision_policy = api_instance.create_boot_precision_policy(boot_precision_policy)
        pprint(resp_boot_precision_policy)
        return resp_boot_precision_policy
    except intersight.ApiException as e:
        print("Exception when calling BootApi->create_boot_precision_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of boot precision policy
    create_boot_precision_policy()