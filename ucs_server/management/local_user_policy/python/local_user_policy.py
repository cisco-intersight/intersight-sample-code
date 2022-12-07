from authentication.python.intersight_authentication import client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.iam_end_point_user_policy import IamEndPointUserPolicy
from intersight.model.iam_end_point_password_properties import IamEndPointPasswordProperties
from intersight.api import iam_api
import intersight

from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization")


def create_end_point_user_policy():
    api_instance = iam_api.IamApi(api_client)

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

    try:
        # Create a 'iam.EndPointUserPolicy' resource.
        resp_user_policy = api_instance.create_iam_end_point_user_policy(user_policy)
        pprint(resp_user_policy)
        return resp_user_policy
    except intersight.ApiException as e:
        print("Exception when calling IamApi->create_end_point_user_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # # Trigger creation of end point user policy
    create_end_point_user_policy()