from authentication.python import intersight_authentication as client

from intersight.api import chassis_api, power_api, snmp_api, thermal_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.chassis_profile import ChassisProfile
from intersight.model.power_policy import PowerPolicy
from intersight.model.snmp_policy import SnmpPolicy
from intersight.model.thermal_policy import ThermalPolicy
from intersight.model.policy_abstract_policy_relationship import PolicyAbstractPolicyRelationship
import intersight
import sys

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    api_instance = organization_api.OrganizationApi(api_client)
    organization_name = 'default'
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

def create_power_policy():
    # Create an instance of the API class.
    api_instance = power_api.PowerApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    power_policy = PowerPolicy(name="sample_power_policy",organization=organization)
    api_response = api_instance.create_power_policy(power_policy)
    return  PolicyAbstractPolicyRelationship(class_id="mo.MoRef",
                                             object_type=api_response.object_type,
                                             moid=api_response.moid)
def create_snmp_policy():
    # Create an instance of the API class.
    api_instance = snmp_api.SnmpApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    snmp_policy = SnmpPolicy(name="sample_snmp_policy",organization=organization)
    api_response = api_instance.create_snmp_policy(snmp_policy)
    return  PolicyAbstractPolicyRelationship(class_id="mo.MoRef",
                                             object_type=api_response.object_type,
                                             moid=api_response.moid)
def create_thermal_policy():
    # Create an instance of the API class.
    api_instance = thermal_api.ThermalApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    thermal_policy = ThermalPolicy(name="sample_thermal_policy", organization=organization)
    api_response = api_instance.create_thermal_policy(thermal_policy)
    return  PolicyAbstractPolicyRelationship(class_id="mo.MoRef",
                                             object_type=api_response.object_type,
                                             moid=api_response.moid)
    
def create_ucs_chassis_profile():
    # Create an instance of the API class.
    api_instance = chassis_api.ChassisApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create a reference to different policies
    powerPolicyRef = create_power_policy()
    snmpPolicyRef = create_snmp_policy()
    thermalPolicyRef = create_thermal_policy()
    # Create an instance of policy bucket
    policy_bucket = [powerPolicyRef, snmpPolicyRef, thermalPolicyRef]
    # ChassisProfile | The 'ChassisProfile' resource to create.
    chassis_profile = ChassisProfile(name="sample_chassis_profile_1",
                                     organization=organization,
                                     policy_bucket=policy_bucket)
    try:
        # Create a 'Chassis.Profile' resource.
        api_response = api_instance.create_chassis_profile(chassis_profile)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling ServerApi->patch_server_profile: %s\n" % e)
        sys.exit(1)

if __name__ == "__main__":
    # Trigger creation of ucs chassis profile
    create_ucs_chassis_profile()