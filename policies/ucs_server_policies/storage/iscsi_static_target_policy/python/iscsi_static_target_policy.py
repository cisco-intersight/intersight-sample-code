import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.vnic_iscsi_static_target_policy import VnicIscsiStaticTargetPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_iscsi_static_target_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # VnicIscsiStaticTargetPolicy | The 'VnicIscsiStaticTarget.Policy' resource to create.
    iscsiStaticTargetPolicy = VnicIscsiStaticTargetPolicy()
    # Setting all the attributes for iscsiStaticTargetPolicy instance.
    iscsiStaticTargetPolicy.name = "sample_iscsi_static_target_policy"
    iscsiStaticTargetPolicy.ip_address = "25.25.25.25"
    iscsiStaticTargetPolicy.port = 650
    iscsiStaticTargetPolicy.target_name = "iqn.2012-02.com.ibm.de.boeblingen:01:c5f446d488f4"
    try:
        # Create a 'VnicIscsiStaticTarget.Policy' resource.
        api_response = api_instance.create_vnic_iscsi_static_target_policy(iscsiStaticTargetPolicy)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_iscsi_static_target_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of iscsi static target policy
    create_iscsi_static_target_policy()
