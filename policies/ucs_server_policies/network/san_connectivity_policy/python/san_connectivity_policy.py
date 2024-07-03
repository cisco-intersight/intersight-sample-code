import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_san_connectivity_policy import VnicSanConnectivityPolicy

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

def create_san_connectivity_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # VnicSanConnectivityPolicy | The 'VnicSanConnectivity.Policy' resource to create.
    vnic_san_cnn_pol1 = VnicSanConnectivityPolicy(name="sample_san_connectivity_policy",
                                                  organization=organization,
                                                  placement_mode="custom",
                                                  target_platform="Standalone",
                                                  wwnn_address_type="POOL")
    try:
        # Create a 'VnicSanConnectivity.Policy' resource.
        api_response1 = api_instance.create_vnic_san_connectivity_policy(vnic_san_cnn_pol1)
        print(api_response1)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_san_connectivity_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of san connectivity policy
    create_san_connectivity_policy()
