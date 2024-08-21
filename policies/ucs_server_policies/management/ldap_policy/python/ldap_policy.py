import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import iam_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.iam_ldap_policy import IamLdapPolicy
from intersight.model.iam_ldap_base_properties import IamLdapBaseProperties
from intersight.model.iam_end_point_role_relationship import IamEndPointRoleRelationship
from intersight.model.iam_ldap_policy_relationship import IamLdapPolicyRelationship
from intersight.model.iam_end_point_role_relationship import IamEndPointRoleRelationship
from intersight.model.iam_ldap_provider import IamLdapProvider
from intersight.model.iam_ldap_provider_relationship import IamLdapProviderRelationship
from intersight.model.iam_ldap_group import IamLdapGroup

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def get_organization(organization_name = 'default'):
    # Get the organization and return OrganizationRelationship
    api_instance = organization_api.OrganizationApi(api_client)
    odata = {"filter":f"Name eq {organization_name}"}
    organizations = api_instance.get_organization_organization_list(**odata)
    if organizations.results and len(organizations.results) > 0:
        moid = organizations.results[0].moid
    else:
        print("No organization was found with given name")
        sys.exit(1)
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid=moid)

# Create an instance of the API class.
api_instance = iam_api.IamApi(api_client)

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
    # Create an instance of organization.
    organization = get_organization()
    base_prop = iam_ldap_base_properties()
    # IamLdapPolicy | The 'IamLdap.Policy' resource to create.
    iam_ldap_pol1 = IamLdapPolicy(name="sample_ldap_policy", base_properties=base_prop, EnableDns=False, organization=organization)
    # Create a 'IamLdap.Policy' resource.
    api_response1 = api_instance.create_iam_ldap_policy(iam_ldap_pol1)
    return api_response1


def create_ldap_policy_ref(ldap_policy):
    return IamLdapPolicyRelationship(class_id="mo.MoRef",
                                     object_type="iam.LdapPolicy",
                                     moid=ldap_policy.moid)

def create_iam_endpoint_role_ref():
    params = {"filter":"Name eq 'admin'"}
    api_response = api_instance.get_iam_end_point_role_list(**params)
    return IamEndPointRoleRelationship(class_id="mo.MoRef",
                                       object_type="iam.EndPointRole",
                                       moid=api_response.results[0].moid)

def create_ldap_provider_ref(ldap_policy_ref):
    ldap_provider = IamLdapProvider(port=389,
                                    server="ldap.xyz.com",
                                    ldap_policy=ldap_policy_ref)
    api_response = api_instance.create_iam_ldap_provider(ldap_provider)
    return IamLdapProviderRelationship(class_id="mo.MoRef",
                                       object_type="iam.LdapProvider",
                                       moid=api_response.moid)

def create_ldap_group(ldap_policy, endpoint_role):
    # Create an instance of ldap group
    ldap_group = IamLdapGroup(domain="xyz.com",
                              name="ldap_group",
                              ldap_policy=ldap_policy,
                              end_point_role=[endpoint_role])
    try:
        api_response = api_instance.create_iam_ldap_group(ldap_group)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling IamApi->create_iam_ldap_group: %s\n" % e)
        sys.exit(1)
    
if __name__ == "__main__":
    # Trigger creation of ldap policy
    ldap_policy = create_ldap_policy()
    ldap_policy_ref= create_ldap_policy_ref(ldap_policy)
    endpoint_role_ref = create_iam_endpoint_role_ref()
    ldap_provider_ref = create_ldap_provider_ref(ldap_policy_ref)
    create_ldap_group(ldap_policy_ref, endpoint_role_ref)
