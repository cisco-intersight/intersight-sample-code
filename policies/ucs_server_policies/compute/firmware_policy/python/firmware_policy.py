from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.firmware_policy import FirmwarePolicy
from intersight.model.firmware_model_bundle_version import FirmwareModelBundleVersion
from intersight.api import firmware_api, organization_api
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


def create_firmware_policy():
    api_instance = firmware_api.FirmwareApi(api_client)

    # Create an instance of organization and firmware model bundle version.
    organization = get_organization()

    model_bundle_version = FirmwareModelBundleVersion(model_family="UCSC-C220-M7",
                                                      bundle_version="4.3(3.240043)")

    # FirmwarePolicy | The 'firmware.Policy' resource to create.
    firmware_policy = FirmwarePolicy()

    # Setting attributes for firmware_policy instance.
    firmware_policy.name = "sample_firmware_policy"
    firmware_policy.target_platform = "Standalone"
    firmware_policy.model_bundle_combo = [model_bundle_version]
    firmware_policy.organization = organization

    try:
        # Create a 'firmware.Policy' resource.
        resp_firmware_policy = api_instance.create_firmware_policy(firmware_policy)
        pprint(resp_firmware_policy)
        return resp_firmware_policy
    except intersight.ApiException as e:
        print("Exception when calling FirmwareApi->create_firmware_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of firmware policy
    create_firmware_policy()