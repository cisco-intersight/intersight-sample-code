import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_iscsi_boot_policy import VnicIscsiBootPolicy
from intersight.model.vnic_iscsi_static_target_policy import VnicIscsiStaticTargetPolicy
from intersight.model.vnic_iscsi_static_target_policy_relationship import VnicIscsiStaticTargetPolicyRelationship
from intersight.model.vnic_iscsi_auth_profile import VnicIscsiAuthProfile
from intersight.model.ippool_ip_v4_config import IppoolIpV4Config
from intersight.model.vnic_iscsi_adapter_policy_relationship import VnicIscsiAdapterPolicyRelationship

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)
# Create an instance of the API class.
api_instance = vnic_api.VnicApi(api_client)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_vnic_iscsi_static_target_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # VnicIscsiStaticTargetPolicy | The 'VnicIscsiStaticTarget.Policy' resource to create.
    iscsiStaticTargetPolicy = VnicIscsiStaticTargetPolicy()
    # Setting all the attributes for iscsiStaticTargetPolicy instance.
    iscsiStaticTargetPolicy.name = "staticTargetPolicytest2"
    iscsiStaticTargetPolicy.organization = organization
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
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create an instance of VnicIscsiAuthProfile
    chap = VnicIscsiAuthProfile(user_id="test", password="test@11234567")
    mutual_chap = VnicIscsiAuthProfile(user_id="admin", password="test@11234567")
    # Create an instance of IppoolIpV4Config
    initiator_static_ip_v4_config = IppoolIpV4Config(gateway="172.16.2.1", netmask="255.255.255.0")
    # Create an instance of VnicIscsiAdapterPolicy
    iscsi_adapter_policy = VnicIscsiAdapterPolicyRelationship(class_id="mo.MoRef",
                                                              object_type="vnic.IscsiAdapterPolicy",
                                                              moid="moid_of_your_iscsci_adapter_policy")
    # VnicIscsiBootPolicy | The 'VnicIscsiBoot.Policy' resource to create.
    iscsi_boot_pol = VnicIscsiBootPolicy(name="sample_iscsi_boot_policy1")
    iscsi_boot_pol.organization = organization
    iscsi_boot_pol.initiator_ip_source = "Static"
    iscsi_boot_pol.target_source_type = "Static"
    iscsi_boot_pol.chap = chap
    iscsi_boot_pol.initiator_static_ip_v4_address = "172.16.2.19"
    iscsi_boot_pol.initiator_static_ip_v4_config = initiator_static_ip_v4_config
    iscsi_boot_pol.iscsi_adapter_policy = iscsi_adapter_policy
    iscsi_boot_pol.primary_target_policy = stat_pol_ref
    iscsi_boot_pol.mutual_chap = mutual_chap
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
