import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.vnic_lan_connectivity_policy import VnicLanConnectivityPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_lan_connectivity_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)

    # Create lan connectivity policy
    vnic_lan_cnn_pol1 = VnicLanConnectivityPolicy(name="sample_lan_policy1")
    try:
        # Create a 'VnicLanConnectivity.Policy' resource.
        api_response1 = api_instance.create_vnic_lan_connectivity_policy(vnic_lan_cnn_pol1)
        print(api_response1)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_lan_connectivity_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of lan connectivity policy
    create_lan_connectivity_policy()
