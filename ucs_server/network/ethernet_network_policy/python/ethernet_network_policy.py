import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.vnic_eth_network_policy import VnicEthNetworkPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_ethernet_network_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # VnicEthNetworkPolicy | The 'VnicEthNetwork.Policy' resource to create.
    vnic_eth_qos = VnicEthNetworkPolicy(name="sample_ethernet_network_policy")
    try:
        # Create a 'VnicEthNetwork.Policy' resource.
        api_response = api_instance.create_vnic_eth_network_policy(vnic_eth_qos)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_eth_network_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ethernet network policy
    create_ethernet_network_policy()
