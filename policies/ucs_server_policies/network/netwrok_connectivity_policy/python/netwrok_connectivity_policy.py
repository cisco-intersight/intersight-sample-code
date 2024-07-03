import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import networkconfig_api, organization_api
from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.networkconfig_policy import NetworkconfigPolicy

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

def create_network_connectivity_policy():
    # Create an instance of the API class.
    api_instance = networkconfig_api.NetworkconfigApi(api_client)
    # Create an instance of organization.
    organization = create_organization()
    # NetworkconfigPolicy | The 'Networkconfig.Policy' resource to create.
    vnic_lan_cnn_pol1 = NetworkconfigPolicy(name="sample_network_config_policy",
                                            description="test network config policy",
                                            organization=organization,
                                            enable_dynamic_dns=True,
                                            dynamic_dns_domain="xyz.com",
                                            enable_ipv6=False,
                                            alternate_ipv4dns_server="22.22.22.22",
                                            preferred_ipv4dns_server="171.70.98.1",)
    try:
        # Create a 'Networkconfig.Policy' resource.
        api_response1 = api_instance.create_networkconfig_policy(vnic_lan_cnn_pol1)
        print(api_response1)
    except intersight.ApiException as e:
        print("Exception when calling networkconfig_api->create_networkconfig_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of network config policy
    create_network_connectivity_policy()
