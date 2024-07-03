import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_iscsi_static_target_policy import VnicIscsiStaticTargetPolicy
from intersight.model.vnic_lun import VnicLun

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

def create_iscsi_static_target_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # Create instance of VnicLun
    lun = VnicLun(bootable=True, lun_id=100)
    # VnicIscsiStaticTargetPolicy | The 'VnicIscsiStaticTarget.Policy' resource to create.
    iscsiStaticTargetPolicy = VnicIscsiStaticTargetPolicy()
    # Setting all the attributes for iscsiStaticTargetPolicy instance.
    iscsiStaticTargetPolicy.name = "sample_iscsi_static_target_policy"
    iscsiStaticTargetPolicy.organization = organization
    iscsiStaticTargetPolicy.ip_address = "25.25.25.25"
    iscsiStaticTargetPolicy.port = 650
    iscsiStaticTargetPolicy.lun = lun
    iscsiStaticTargetPolicy.target_name = "iqn.2012-02.com.ibm.de.boeblingen:01:c5f446d488f4"
    try:
        # Create a 'VnicIscsiStaticTarget.Policy' resource.
        api_response = api_instance.create_vnic_iscsi_static_target_policy(iscsiStaticTargetPolicy)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_iscsi_static_target_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of iscsi static target policy
    create_iscsi_static_target_policy()
