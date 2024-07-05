from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.snmp_policy import SnmpPolicy
from intersight.model.snmp_user import SnmpUser
from intersight.model.snmp_trap import SnmpTrap
from intersight.api import snmp_api, organization_api
import intersight

from pprint import pprint
import sys


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

def create_snmp_policy():
    # Create an instance of the API class
    api_instance = snmp_api.SnmpApi(api_client)

    # Create an instance of organization and snmp user.
    organization = get_organization()
    snmp_user = SnmpUser(class_id="snmp.User",
                         object_type="snmp.User",
                         auth_type="SHA",
                         privacy_type="AES",
                         security_level="AuthPriv",
                         name="user1",
                         auth_password="Auth_Snmp_user1",
                         privacy_password="Priv_Snmp_user1")
    snmp_trap = SnmpTrap(class_id="snmp.Trap",
                         object_type="snmp.Trap",
                         community="trapCommString",
                         destination="11.11.11.11",
                         enabled=True,
                         port=162,
                         type="Trap",
                         version="V2")

    # SnmpPolicy | The 'snmp.Policy' resource to create.
    snmp_policy = SnmpPolicy()

    # Setting all the attributes for snmp_policy instance.
    snmp_policy.name = "sample_snmp_policy1"
    snmp_policy.description = "sample snmp policy."
    snmp_policy.enabled = True
    snmp_policy.sys_location = "BLR"
    snmp_policy.trap_community = "snmpv3"
    snmp_policy.engine_id = "12121"
    snmp_policy.snmp_port = 161
    snmp_policy.sys_contact = "DA"
    snmp_policy.snmp_users = [snmp_user]
    snmp_policy.access_community_string = "access_comm_string"
    snmp_policy.community_access = "Disabled"
    snmp_policy.sys_location = "NYK"
    snmp_policy.snmp_traps = [snmp_trap]
    snmp_policy.organization = organization

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'Snmp.Policy' resource.
        resp_snmp_policy = api_instance.create_snmp_policy(snmp_policy)
        pprint(resp_snmp_policy)
        return resp_snmp_policy
    except intersight.ApiException as e:
        print("Exception when calling SnmpApi->create_snmp_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of snmp policy
    create_snmp_policy()