from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.fabric_link_aggregation_policy import FabricLinkAggregationPolicy
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

def create_link_aggregation_policy():
    api_instance = fabric_api.FabricApi(api_client)

    # Create an instance of organization.
    organization = create_organization()

    # FabricLinkAggregationPolicy | The 'fabric.LinkAggregationPolicy' resource to create.
    link_aggr_policy = FabricLinkAggregationPolicy()

    # Setting all the attributes for link_aggr_policy instance.
    link_aggr_policy.name = "sample_link_aggr_policy1"
    link_aggr_policy.description = "sample link aggregation policy."
    link_aggr_policy.organization = organization
    link_aggr_policy.lacp_rate = "normal"
    link_aggr_policy.suspend_individual = True

    # Example passing only required values which don't have defaults set
    try:
        # Create a 'fabric.LinkAggregationPolicy' resource.
        resp_link_aggr_policy = api_instance.create_fabric_link_aggregation_policy(link_aggr_policy)
        pprint(resp_link_aggr_policy)
        return resp_link_aggr_policy
    except intersight.ApiException as e:
        print("Exception when calling FabricApi->create_link_aggregation_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of link aggregation policy
    create_link_aggregation_policy()