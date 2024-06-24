import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.vnic_fc_qos_policy import VnicFcQosPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_fiber_channel_qos_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # VnicFcQosPolicy | The 'VnicFcQos.Policy' resource to create.
    fc_qos_pol = VnicFcQosPolicy(name="sample_fiber_channel_qos_policy")
    try:
        # Create a 'VnicFcQos.Policy' resource.
        api_response = api_instance.create_vnic_fc_qos_policy(fc_qos_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_fc_qos_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of fiber channel qos policy
    create_fiber_channel_qos_policy()
