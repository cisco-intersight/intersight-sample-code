import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import networkconfig_api
from intersight.model.networkconfig_policy import NetworkconfigPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_network_connectivity_policy():
    # Create an instance of the API class.
    api_instance = networkconfig_api.NetworkconfigApi(api_client)
    # NetworkconfigPolicy | The 'Networkconfig.Policy' resource to create.
    vnic_lan_cnn_pol1 = NetworkconfigPolicy(name="sample_network_config_policy")
    try:
        # Create a 'Networkconfig.Policy' resource.
        api_response1 = api_instance.create_networkconfig_policy(vnic_lan_cnn_pol1)
        print(api_response1)
    except intersight.ApiException as e:
        print("Exception when calling networkconfig_api->create_networkconfig_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of network config policy
    create_network_connectivity_policy()
