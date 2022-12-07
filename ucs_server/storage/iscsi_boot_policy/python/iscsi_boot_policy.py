import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.vnic_iscsi_boot_policy import VnicIscsiBootPolicy
from intersight.model.vnic_iscsi_static_target_policy import VnicIscsiStaticTargetPolicy
from intersight.model.vnic_iscsi_static_target_policy_relationship import VnicIscsiStaticTargetPolicyRelationship


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)
# Create an instance of the API class.
api_instance = vnic_api.VnicApi(api_client)


def create_vnic_iscsi_static_target_policy():
    # VnicIscsiStaticTargetPolicy | The 'VnicIscsiStaticTarget.Policy' resource to create.
    iscsiStaticTargetPolicy = VnicIscsiStaticTargetPolicy()
    # Setting all the attributes for iscsiStaticTargetPolicy instance.
    iscsiStaticTargetPolicy.name = "staticTargetPolicytest2"
    iscsiStaticTargetPolicy.ip_address = "25.25.25.25"
    iscsiStaticTargetPolicy.port = 650
    iscsiStaticTargetPolicy.target_name = "iqn.2012-02.com.ibm.de.boeblingen:01:c5f446d488f4"
    try:
        # Create a 'VnicIscsiStaticTarget.Policy' resource.
        api_response = api_instance.create_vnic_iscsi_static_target_policy(iscsiStaticTargetPolicy)
        print(api_response)
        return api_response
    except intersight.ApiException as e:
        print("Exception when calling NtpApi->create_ntp_policy: %s\n" % e)
        sys.exit(1)


def create_policy_reference(policy_moid, obj_type):
    return VnicIscsiStaticTargetPolicyRelationship(moid=policy_moid,
                                            object_type=obj_type,
                                            class_id="mo.MoRef")


def create_boot_policy(stat_pol_ref):
    # VnicIscsiBootPolicy | The 'VnicIscsiBoot.Policy' resource to create.
    iscsi_boot_pol = VnicIscsiBootPolicy(name="sample_iscsi_boot_policy1")
    iscsi_boot_pol.primary_target_policy = stat_pol_ref
    try:
        # Create a 'VnicIscsiBoot.Policy' resource.
        api_response = api_instance.create_vnic_iscsi_boot_policy(iscsi_boot_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_iscsi_boot_policy: %s\n" % e)


if __name__ == "__main__":
    # Trigger creation of iscsi boot policy
    stat_pol = create_vnic_iscsi_static_target_policy()
    stat_pol_ref = create_policy_reference(stat_pol.moid, "vnic.IscsiStaticTargetPolicy")
    create_boot_policy(stat_pol_ref)
