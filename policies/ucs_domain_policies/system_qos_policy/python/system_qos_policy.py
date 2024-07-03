from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_system_qos_policy import FabricSystemQosPolicy
from intersight.model.fabric_qos_class import FabricQosClass
from intersight.api import fabric_api, organization_api
import intersight

from pprint import pprint
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


def create_system_qos_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization and qos class.
    organization = create_organization()
    qos_class = FabricQosClass(name="Silver",
                               admin_state="Enabled",
                               bandwidth_percent=40,
                               mtu=2000,
                               weight=5)

    # FabricSystemQosPolicy | The 'fabric.SystemQosPolicy' resource to create.
    sys_qos_policy = FabricSystemQosPolicy()

    # Setting all the attributes for sys_qos_policy instance.
    sys_qos_policy.name = "sample_sys_qos_policy1"
    sys_qos_policy.description = "sample system qos policy."
    sys_qos_policy.organization = organization
    sys_qos_policy.classes = [qos_class]

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.SystemQosPolicy' resource.
        resp_sys_qos_policy = api_instance.create_fabric_system_qos_policy(sys_qos_policy)
        pprint(resp_sys_qos_policy)
        return resp_sys_qos_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_system_qos_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of system qos policy
    create_system_qos_policy()