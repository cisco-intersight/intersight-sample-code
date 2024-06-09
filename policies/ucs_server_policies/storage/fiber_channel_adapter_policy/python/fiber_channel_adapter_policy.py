import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.vnic_fc_adapter_policy import VnicFcAdapterPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_fiber_channel_adapter_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # VnicFcAdapterPolicy | The 'VnicFcAdapter.Policy' resource to create.
    fc_adap_pol = VnicFcAdapterPolicy(name="sample_fiber_channel_adapter_policy")
    try:
        # Create a 'VnicFcAdapter.Policy' resource.
        api_response = api_instance.create_vnic_fc_adapter_policy(fc_adap_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_fc_adapter_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of fiber channel adapter policy
    create_fiber_channel_adapter_policy()
