import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_fc_network_policy import VnicFcNetworkPolicy
from intersight.model.vnic_vsan_settings import VnicVsanSettings

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_fiber_channel_network_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create an instance of VnicVsanSettings
    vsan_settings = VnicVsanSettings(id=22, default_vlan_id=22)
    # VnicFcNetworkPolicy | The 'VnicFcNetwork.Policy' resource to create.
    fc_net_pol = VnicFcNetworkPolicy(name="sample_fiber_channel_network_policy",
                                     organization=organization,
                                     vsan_settings=vsan_settings)
    try:
        # Create a 'VnicFcNetwork.Policy' resource.
        api_response = api_instance.create_vnic_fc_network_policy(fc_net_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_fc_network_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of fiber channel network policy
    create_fiber_channel_network_policy()
