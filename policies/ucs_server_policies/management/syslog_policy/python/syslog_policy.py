from authentication.python import intersight_authentication as client

from intersight.model.organization_organization_relationship import OrganizationOrganizationRelationship
from intersight.model.syslog_policy import SyslogPolicy
from intersight.model.syslog_local_client_base import SyslogLocalClientBase
from intersight.model.syslog_remote_client_base import SyslogRemoteClientBase
from intersight.api import syslog_api
import intersight

from pprint import pprint
import sys


api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_organization():
    # Creating an instance of organization using its moid, under which policy should be created
    return OrganizationOrganizationRelationship(class_id="mo.MoRef",
                                                object_type="organization.Organization",
                                                moid="moid_of_organization")

def create_syslog_policy():
    api_instance = syslog_api.SyslogApi(api_client)

    # Create an instance of organization and syslog client.
    organization = create_organization()
    syslog_client = SyslogLocalClientBase(class_id="syslog.LocalFileLoggingClient",
                                          object_type="syslog.LocalFileLoggingClient",
                                          min_severity="warning")
    syslog_remote_client = SyslogRemoteClientBase(class_id="syslog.RemoteLoggingClient",
                                                  object_type="syslog.RemoteLoggingClient",
                                                  enabled=True,
                                                  hostname="11.11.11.11",
                                                  min_severity="warning",
                                                  port=514,
                                                  protocol="udp")

    # SyslogPolicy | The 'syslog.Policy' resource to create.
    syslog_policy = SyslogPolicy()

    # Setting all the attributes for syslog_policy instance.
    syslog_policy.name = "sample_syslog_policy1"
    syslog_policy.description = "sample syslog policy."
    syslog_policy.organization = organization
    syslog_policy.local_clients = [syslog_client]
    syslog_policy.remote_clients = [syslog_remote_client]


    # Example passing only required values which don't have defaults set
    try:
        # Create a 'syslog.Policy' resource.
        resp_syslog_policy = api_instance.create_syslog_policy(syslog_policy)
        pprint(resp_syslog_policy)
        return resp_syslog_policy
    except intersight.ApiException as e:
        print("Exception when calling SyslogApi->create_syslog_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of syslog policy
    create_syslog_policy()