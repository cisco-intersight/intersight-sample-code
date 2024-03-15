import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.vnic_san_connectivity_policy import VnicSanConnectivityPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_san_connectivity_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # VnicSanConnectivityPolicy | The 'VnicSanConnectivity.Policy' resource to create.
    vnic_san_cnn_pol1 = VnicSanConnectivityPolicy(name="sample_san_connectivity_policy")
    try:
        # Create a 'VnicSanConnectivity.Policy' resource.
        api_response1 = api_instance.create_vnic_san_connectivity_policy(vnic_san_cnn_pol1)
        print(api_response1)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_san_connectivity_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of san connectivity policy
    create_san_connectivity_policy()
