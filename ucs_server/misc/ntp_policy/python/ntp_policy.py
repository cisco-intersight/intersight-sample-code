import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import ntp_api
from intersight.model.ntp_policy import NtpPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_ntp_policy():
    # Create an instance of the API class.
    api_instance = ntp_api.NtpApi(api_client)
    # NtpPolicy | The 'Ntp.Policy' resource to create.
    ntp_pol = NtpPolicy(name="sample_ntp_policy", ntp_servers=["1.1.1.1"])
    try:
        # Create a 'Ntp.Policy' resource.
        api_response = api_instance.create_ntp_policy(ntp_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling NtpApi->create_ntp_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ntp policy
    create_ntp_policy()
