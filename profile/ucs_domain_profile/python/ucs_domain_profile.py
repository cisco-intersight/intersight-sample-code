import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import fabric_api
from intersight.model.fabric_switch_profile import FabricSwitchProfile
from intersight.model.fabric_switch_cluster_profile import FabricSwitchClusterProfile
from intersight.model.fabric_switch_cluster_profile_relationship import FabricSwitchClusterProfileRelationship

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)
# Create an instance of the API class.
api_instance = fabric_api.FabricApi(api_client)


def create_fabric_switch_cluster_profile():
    fabric_switch_cluster_profile = FabricSwitchClusterProfile(name="sample_switch_cluster_profile")
    cluster_profile = api_instance.create_fabric_switch_cluster_profile(fabric_switch_cluster_profile)
    return cluster_profile


def create_policy_reference(cluster_profile):
    profile_ref = FabricSwitchClusterProfileRelationship(
        moid=cluster_profile.moid, object_type="fabric.SwitchClusterProfile", class_id="mo.MoRef")
    return profile_ref


def create_fabric_switch_profile(profile_ref):
    switch_prof = FabricSwitchProfile(name="sample_fabric_switch_profile")
    switch_prof.switch_cluster_profile = profile_ref
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
    create_fabric_switch_profile(policy_ref)
