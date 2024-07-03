import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import adapter_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.adapter_config_policy import AdapterConfigPolicy
from intersight.model.adapter_adapter_config import AdapterAdapterConfig
from intersight.model.adapter_eth_settings import AdapterEthSettings
from intersight.model.adapter_fc_settings import AdapterFcSettings
from intersight.model.adapter_port_channel_settings import AdapterPortChannelSettings
from intersight.model.adapter_dce_interface_settings import AdapterDceInterfaceSettings


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

def create_adapter_configuration_policy():
    # Create an instance of the API class.
    api_instance = adapter_api.AdapterApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    adaptor_fc_settings = AdapterFcSettings(FipEnabled=True)
    adaptor_port_channel_settings = AdapterPortChannelSettings(Enabled=True)
    adapter_eth_settings = AdapterEthSettings(LldpEnabled=True)
    adapter_dce_interface_settings = AdapterDceInterfaceSettings(FecMode="cl91",InterfaceId=1)

    # Settings the attributes for Adapter policy
    adaptor_adaptor_config = AdapterAdapterConfig()
    adaptor_adaptor_config.SlotId = "15"
    adaptor_adaptor_config.EthSettings = adapter_eth_settings
    adaptor_adaptor_config.FcSettings = adaptor_fc_settings
    adaptor_adaptor_config.PortChannelSettings = adaptor_port_channel_settings
    adaptor_adaptor_config.DceInterfaceSettings = [adapter_dce_interface_settings]

    # AdapterConfigPolicy | The 'AdapterConfig.Policy' resource to create.
    adaptor_config_policy = AdapterConfigPolicy(name="sample_acp_policy")
    adaptor_config_policy.settings = [adaptor_adaptor_config]
    adaptor_config_policy.organization = organization

    try:
        # Create a 'AdapterConfig.Policy' resource.
        api_response = api_instance.create_adapter_config_policy(adaptor_config_policy)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling AdapterApi->create_adapter_config_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of adapter configuration policy
    create_adapter_configuration_policy()
