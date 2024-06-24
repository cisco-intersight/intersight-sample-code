import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import fabric_api, power_api, snmp_api, thermal_api
from intersight.model.power_policy import PowerPolicy
from intersight.model.snmp_policy import SnmpPolicy
from intersight.model.thermal_policy import ThermalPolicy
from intersight.model.policy_abstract_policy_relationship import PolicyAbstractPolicyRelationship
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_switch_profile import FabricSwitchProfile
from intersight.model.fabric_switch_cluster_profile import FabricSwitchClusterProfile
from intersight.model.fabric_switch_cluster_profile_relationship import FabricSwitchClusterProfileRelationship

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)
# Create an instance of the API class.
api_instance = fabric_api.FabricApi(api_client)
												
def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

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

def get_policy_bucket():
    powerPolicyRef = create_power_policy()
    snmpPolicyRef = create_snmp_policy()
    thermalPolicyRef = create_thermal_policy()
    policy_bucket = [powerPolicyRef, snmpPolicyRef, thermalPolicyRef]
    return policy_bucket


def create_fabric_switch_cluster_profile():
    # Create an instance of organization.
    organization = create_organization()
    fabric_switch_cluster_profile = FabricSwitchClusterProfile(name="sample_switch_cluster_profile",
                                                               organization=organization)
    cluster_profile = api_instance.create_fabric_switch_cluster_profile(fabric_switch_cluster_profile)
    return cluster_profile

def create_policy_reference(cluster_profile):
    # Create an instance of organization.
    organization = create_organization()
    profile_ref = FabricSwitchClusterProfileRelationship(moid=cluster_profile.moid,
                                                         object_type="fabric.SwitchClusterProfile",
                                                         class_id="mo.MoRef",
                                                         organization=organization)
    return profile_ref


def create_fabric_switch_profile(profile_ref, policy_bucket):
    switch_prof = FabricSwitchProfile(name="sample_fabric_switch_profile")
    switch_prof.switch_cluster_profile = profile_ref
    switch_prof.policy_bucket = policy_bucket
    try:
        api_response = api_instance.create_fabric_switch_profile(switch_prof)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_fabric_switch_profile: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of ucs domain profile
    cluster_prof = create_fabric_switch_cluster_profile()
    policy_ref = create_policy_reference(cluster_prof)
    policy_bucket = get_policy_bucket()
    create_fabric_switch_profile(policy_ref, policy_bucket)