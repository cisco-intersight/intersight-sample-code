from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_switch_control_policy import FabricSwitchControlPolicy
from intersight.model.fabric_udld_global_settings import FabricUdldGlobalSettings
from intersight.model.fabric_mac_aging_settings import FabricMacAgingSettings
from intersight.api import fabric_api, organization_api
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


def create_switch_control_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = create_organization()
    # Create an instance of FabricMacAgingSettings
    mac_aging_settings = FabricMacAgingSettings(mac_aging_option="Default",
                                                mac_aging_time=14500)
    # Create an instance of FabricUdldGlobalSettings
    udld_settings = FabricUdldGlobalSettings(recovery_action="none",
                                             message_interval=12)

    # FabricSwitchControlPolicy | The 'fabric.SwitchControlPolicy' resource to create.
    switch_control_policy = FabricSwitchControlPolicy()

    # Setting all the attributes for switch_control_policy instance.
    switch_control_policy.name = "sample_switch_control_policy1"
    switch_control_policy.description = "sample switch control policy."
    switch_control_policy.organization = organization
    switch_control_policy.ethernet_switching_mode = "end-host"
    switch_control_policy.fc_switching_mode = "end-host"
    switch_control_policy.udld_settings=udld_settings
    switch_control_policy.mac_aging_settings=mac_aging_settings

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.SwitchControlPolicy' resource.
        resp_switch_control_policy = api_instance.create_fabric_switch_control_policy(switch_control_policy)
        pprint(resp_switch_control_policy)
        return resp_switch_control_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_switch_control_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of switch control policy
    create_switch_control_policy()