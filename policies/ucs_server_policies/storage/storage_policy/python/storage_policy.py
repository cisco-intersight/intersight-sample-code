import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import storage_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.storage_storage_policy import StorageStoragePolicy
from intersight.model.storage_m2_virtual_drive_config import StorageM2VirtualDriveConfig
from intersight.model.storage_r0_drive import StorageR0Drive
from intersight.model.storage_virtual_drive_policy import StorageVirtualDrivePolicy

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

def create_storage_policy():
    # Create an instance of the API class.
    api_instance = storage_api.StorageApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create an instance of StorageM2VirtualDriveConfig
    m2_virtual_drive = StorageM2VirtualDriveConfig(enable=True,
                                                   controller_slot="MSTOR-RAID-1")
    # Create an instance of StorageVirtualDrivePolicy for use in StorageR0Drive
    virtual_drive_policy = StorageVirtualDrivePolicy(drive_cache="Default",
                                                     read_policy="Default",
                                                     strip_size=512,
                                                     access_policy ="Default")
    # Create an instance of StorageR0Drive
    raid0_drive = StorageR0Drive(enable=True,
                                 virtual_drive_policy=virtual_drive_policy)
    # StorageStoragePolicy | The 'StorageStorage.Policy' resource to create.
    storage_pol = StorageStoragePolicy(name="sample_storage_policy",
                                       organization=organization,
                                       default_drive_mode="RAID0",
                                       m2_virtual_drive=m2_virtual_drive,
                                       raid0_drive=raid0_drive)
    try:
        # Create a 'StorageStorage.Policy' resource.
        api_response = api_instance.create_storage_storage_policy(storage_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling StorageApi->create_storage_storage_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of storage policy
    create_storage_policy()
