import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import smtp_api
from intersight.model.smtp_policy import SmtpPolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_smtp_policy():
    # Create an instance of the API class.
    api_instance = smtp_api.SmtpApi(api_client)
    # SmtpPolicy | The 'Smtp.Policy' resource to create.
    smtp_pol = SmtpPolicy(name="sample_smtp", smtp_server="samplesmtp.intersight.com")
    try:
        # Create a 'Smtp.Policy' resource.
        api_response = api_instance.create_smtp_policy(smtp_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling SmtpApi->create_smtp_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of smtp policy
    create_smtp_policy()
