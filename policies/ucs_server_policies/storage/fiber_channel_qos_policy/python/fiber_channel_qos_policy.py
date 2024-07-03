import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import vnic_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.vnic_fc_qos_policy import VnicFcQosPolicy

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

def create_fiber_channel_qos_policy():
    # Create an instance of the API class.
    api_instance = vnic_api.VnicApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # VnicFcQosPolicy | The 'VnicFcQos.Policy' resource to create.
    fc_qos_pol = VnicFcQosPolicy(name="sample_fiber_channel_qos_policy",
                                 organization=organization,
                                 burst=1024,
                                 cos=3,
                                 max_data_field_size=2112,
                                 rate_limit=2048)
    try:
        # Create a 'VnicFcQos.Policy' resource.
        api_response = api_instance.create_vnic_fc_qos_policy(fc_qos_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling VnicApi->create_vnic_fc_qos_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of fiber channel qos policy
    create_fiber_channel_qos_policy()
