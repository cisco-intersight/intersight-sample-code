import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_iscsi_adapter_policy import VnicIscsiAdapterPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_iscsi_adapter_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # VnicIscsiAdapterPolicy | The 'VnicIscsiAdapter.Policy' resource to create.
    iscsi_adapt_pol = VnicIscsiAdapterPolicy(name="sample_iscsi_adapter_policy",
                                             organization=organization,
                                             connection_time_out=255,
                                             dhcp_timeout=90,
                                             lun_busy_retry_count=60)
    try:
        # Create a 'VnicIscsiAdapter.Policy' resource.
        api_response = api_instance.create_vnic_iscsi_adapter_policy(iscsi_adapt_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_fc_adapter_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of iscsi adapter policy
    create_iscsi_adapter_policy()
