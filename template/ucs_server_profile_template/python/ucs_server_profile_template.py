import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import server_api
from intersight.model.server_profile_template import ServerProfileTemplate

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_ucs_server_profile_template():
    # Create an instance of the API class.
    api_instance = server_api.ServerApi(api_client)
    # ServerProfileTemplate | The 'ServerProfile.Template' resource to create.
    ser_pro = ServerProfileTemplate(name="sample_ucs_server_profile_template")
    try:
        # Create a 'ServerProfile.Template' resource.
        api_response = api_instance.create_server_profile_template(ser_pro)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling ServerApi->create_server_profile_template: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ucs server profile template
    create_ucs_server_profile_template()
