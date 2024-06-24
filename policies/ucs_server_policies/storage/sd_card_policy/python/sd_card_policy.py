import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import sdcard_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.sdcard_policy import SdcardPolicy
from intersight.model.sdcard_partition import SdcardPartition
from intersight.model.sdcard_virtual_drive import SdcardVirtualDrive

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_sd_card_policy():
    # Create an instance of the API class.
    api_instance = sdcard_api.SdcardApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create an instance of SdcardVirtualDrive for use in SdcardPartition
    virtual_drives = SdcardVirtualDrive(class_id="sdcard.Drivers",
                                        object_type="sdcard.Drivers",
                                        enable=True)
    # Create an instance of SdcardPartition
    partitions = SdcardPartition(type="Utility",
                                 virtual_drives=[virtual_drives])
    # SdcardPolicy | The 'Sdcard.Policy' resource to create.
    sd_card_pol = SdcardPolicy(name="sample_sd_card_policy",
                               organization=organization,
                               partitions=[partitions])
    try:
        # Create a 'Sdcard.Policy' resource.
        api_response = api_instance.create_sdcard_policy(sd_card_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling SdcardApi->create_sdcard_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of sd card policy
    create_sd_card_policy()
