import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import ssh_api
from intersight.model.ssh_policy import SshPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_ssh_policy():
    # Create an instance of the API class.
    api_instance = ssh_api.SshApi(api_client)
    # SshPolicy | The 'Ssh.Policy' resource to create.
    ssh_pol = SshPolicy(name="sample_ssh_policy")
    try:
        # Create a 'Ssh.Policy' resource.
        api_response = api_instance.create_ssh_policy(ssh_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling SshApi->create_ssh_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ssh policy
    create_ssh_policy()
