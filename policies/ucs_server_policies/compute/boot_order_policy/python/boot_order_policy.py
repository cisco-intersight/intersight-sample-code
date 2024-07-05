from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.boot_precision_policy import BootPrecisionPolicy
from intersight.model.boot_device_base import BootDeviceBase
from intersight.model.boot_virtual_media import BootVirtualMedia
from intersight.model.boot_usb import BootUsb
from intersight.model.boot_uefi_shell import BootUefiShell
from intersight.model.boot_pxe import BootPxe
from intersight.model.boot_san import BootSan
from intersight.model.boot_bootloader import BootBootloader
from intersight.api import boot_api, organization_api
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

def create_boot_vmedia():
    # Creating instance of boot_virtual_media
    boot_vmedia  = BootVirtualMedia(class_id="boot.VirtualMedia",
                                    object_type="boot.VirtualMedia",
                                    name="vmedia1",
                                    subtype="cimc-mapped-hdd",
                                    enabled=True)
    return boot_vmedia
    
def create_boot_usb():
    # Creating instance of boot_usb
    boot_usb  = BootUsb(class_id="boot.Usb",
                        object_type="boot.Usb",
                        name="usb1",
                        subtype="usb-fdd",
                        enabled=True)
    return boot_usb

def create_boot_uefi():
    # Creating instance of boot_uefi_shell
    boot_uefi = BootUefiShell(class_id="boot.UefiShell",
                              object_type="boot.UefiShell",
                              name="uefi1",
                              enabled=True)
    return boot_uefi

def create_boot_pxe():
    # Creating instance of boot_pxe
    boot_pxe = BootPxe(class_id="boot.Pxe",
                       object_type="boot.Pxe",
                       name="pxe1",
                       interface_name="eth0",
                       ip_type="IPv4",
                       enabled=True)
    return boot_pxe

def create_bootloader():
    # Creating instance of boot_loader for use in instance of boot_san
    bootloader = BootBootloader(class_id="boot.Bootloader",
                                object_type="boot.Bootloader",
                                name="bootloader")
    return bootloader

def create_boot_san():
    # Creating instance of boot_san
    san_bootloader = create_bootloader()
    boot_san = BootSan(class_id="boot.San",
                       object_type="boot.San",
                       name="san1",
                       interface_name="fc0",
                       wwpn="50:06:01:62:3E:E0:58:36",
                       bootloader=san_bootloader,
                       enabled=True)
    return boot_san



def create_boot_precision_policy():
    api_instance = boot_api.BootApi(api_client)

    # Create an instance of local_cdd, local_disk, vmedia, usb, uefi, pxe, san, organization and list of boot_devices.
    boot_local_cdd = create_boot_local_cdd()
    boot_local_disk = create_boot_local_disk()
    boot_vmedia = create_boot_vmedia()
    boot_usb = create_boot_usb()
    boot_uefi = create_boot_uefi()
    boot_pxe = create_boot_pxe()
    boot_san = create_boot_san()
    organization = get_organization()
    boot_devices = [
        boot_local_disk,
        boot_local_cdd,
        boot_vmedia,
        boot_usb,
        boot_uefi,
        boot_pxe,
        boot_san
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