import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import deviceconnector_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.deviceconnector_policy import DeviceconnectorPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_device_connector_policy():
    api_instance = deviceconnector_api.DeviceconnectorApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    dev_conn_pol = DeviceconnectorPolicy(name="sample_device_connector_policy",
                                         lockout_enabled=True,
                                         organization=organization)
    try:
        api_response = api_instance.create_deviceconnector_policy(dev_conn_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling DeviceconnectorApi->create_deviceconnector_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of device connector policy
    create_device_connector_policy()
