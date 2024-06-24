import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import iam_api
from intersight.model.iam_ldap_policy import IamLdapPolicy
from intersight.model.iam_ldap_base_properties import IamLdapBaseProperties

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def iam_ldap_base_properties():
    # IamLdapBaseProperties | The 'IamLdapBaseProperties' resource to create.
    base_prop = IamLdapBaseProperties()
    # Setting all the attributes for base_prop instance.
    base_prop.BaseDn = "intersight"
    base_prop.Domain = "cisco.com"
    base_prop.Timeout = 60
    base_prop.EnableEncryption = False
    base_prop.BindMethod = "LoginCredentials"
    base_prop.Filter = "cisco"
    base_prop.GroupAttribute = "intersight"
    base_prop.Attribute = "test"
    base_prop.EnableGroupAuthorization = False
    base_prop.NestedGroupSearchDepth = 128
    return base_prop


def create_ldap_policy():
    # Create an instance of the API class.
    api_instance = iam_api.IamApi(api_client)
    base_prop = iam_ldap_base_properties()
    # IamLdapPolicy | The 'IamLdap.Policy' resource to create.
    iam_ldap_pol1 = IamLdapPolicy(name="sample_ldap_policy", base_properties=base_prop, EnableDns=False)
    try:
        # Create a 'IamLdap.Policy' resource.
        api_response1 = api_instance.create_iam_ldap_policy(iam_ldap_pol1)
        print(api_response1)
    except intersight.ApiException as e:
        print("Exception when calling IamApi->create_iam_ldap_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ldap policy
    create_ldap_policy()
