from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.iam_end_point_user_policy import IamEndPointUserPolicy
from intersight.model.iam_end_point_user_policy_relationship import IamEndPointUserPolicyRelationship
from intersight.model.iam_end_point_password_properties import IamEndPointPasswordProperties
from intersight.model.iam_end_point_user_role import IamEndPointUserRole
from intersight.model.iam_end_point_role_relationship import IamEndPointRoleRelationship
from intersight.model.iam_end_point_user import IamEndPointUser
from intersight.model.iam_end_point_user_relationship import IamEndPointUserRelationship
from intersight.api import iam_api, organization_api
import intersight

from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)

# Create an instance of the API class.
api_instance = iam_api.IamApi(api_client)

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


def create_end_point_user_policy():
    

    # Create an instance of organization and password policy.
    organization = create_organization()
    password_property = IamEndPointPasswordProperties(class_id="iam.EndPointPasswordProperties",
                                                    password_history=5,
                                                    enable_password_expiry=False,
                                                    enforce_strong_password=True,
                                                    force_send_password=False)

    # IamEndPointUserPolicy | The 'iam.EndPointUserPolicy' resource to create.
    user_policy = IamEndPointUserPolicy()

    # Setting all the attributes for user_policy instance.
    user_policy.name = "sample_user_policy1"
    user_policy.description = "sample end point user policy."
    user_policy.organization = organization
    user_policy.password_properties = password_property
    # Create a 'iam.EndPointUserPolicy' resource.
    resp_user_policy = api_instance.create_iam_end_point_user_policy(user_policy)
    return IamEndPointUserPolicyRelationship(class_id="mo.MoRef",
                                             object_type="iam.EndPointUserPolicy",
                                             moid=resp_user_policy.moid)

def create_iam_endpoint_role_ref():
    params = {"filter":"Name eq 'admin'"}
    api_response = api_instance.get_iam_end_point_role_list(**params)
    return IamEndPointRoleRelationship(class_id="mo.MoRef",
                                       object_type="iam.EndPointRole",
                                       moid=api_response.results[0].moid)

def create_endpoint_user():
   # Create an instance of organization.
    organization = create_organization() 
    endpoint_user = IamEndPointUser(name="guest",
                                    organization=organization)
    api_response = api_instance.create_iam_end_point_user(endpoint_user)
    return IamEndPointUserRelationship(class_id="mo.MoRef",
                                       object_type="iam.EndPointUser",
                                       moid=api_response.moid)

def create_end_point_user_role():
    # Create an instance of IamEndPointUserRole
    end_point_user_role = IamEndPointUserRole()
    end_point_user_role.enabled = True
    end_point_user_role.end_point_role = [create_iam_endpoint_role_ref()]
    end_point_user_role.password = "admin@1234"
    end_point_user_role.end_point_user_policy = create_end_point_user_policy()
    end_point_user_role.end_point_user = create_endpoint_user()
    try:
        api_response = api_instance.create_iam_end_point_user_role(end_point_user_role)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling IamApi->create_iam_end_point_user_role: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of end point user policy
    create_end_point_user_role()
