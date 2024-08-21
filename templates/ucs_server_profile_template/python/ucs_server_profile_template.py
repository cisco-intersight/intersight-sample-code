import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import server_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.server_profile_template import ServerProfileTemplate
from intersight.model.policy_abstract_policy_relationship import PolicyAbstractPolicyRelationship

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


def create_ucs_server_profile_template():
    # Create an instance of the API class.
    api_instance = server_api.ServerApi(api_client)
    # Create an instance of organization.
    organization = get_organization()
    # Create a reference to different policies
    ntp_policy_ref = PolicyAbstractPolicyRelationship(class_id="mo.MoRef",
                                                      object_type="ntp.Policy",
                                                      moid="moid_of_ntp_policy")
    kvm_policy_ref = PolicyAbstractPolicyRelationship(class_id="mo.MoRef",
                                                      object_type="kvm.Policy",
                                                      moid="moid_of_kvm_policy")
    bios_policy_ref = PolicyAbstractPolicyRelationship(class_id="mo.MoRef",
                                                      object_type="bios.Policy",
                                                      moid="moid_of_bios_policy")
    # Create an instance of policy bucket
    policy_bucket = [ntp_policy_ref, kvm_policy_ref, bios_policy_ref]
    # ServerProfileTemplate | The 'ServerProfile.Template' resource to create.
    ser_pro = ServerProfileTemplate(name="sample_ucs_server_profile_template",
                                    organization=organization,
                                    policy_bucket=policy_bucket)
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
