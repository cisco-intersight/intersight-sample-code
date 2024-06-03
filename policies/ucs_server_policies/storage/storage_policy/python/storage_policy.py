import intersight
import sys

from authentication.python import intersight_authentication as client
from intersight.api import storage_api
from intersight.model.storage_storage_policy import StorageStoragePolicy

api_key = "api_key"
api_key_file = "~/api_key_file_path"

api_client = client.get_api_client(api_key, api_key_file)


def create_storage_policy():
    # Create an instance of the API class.
    api_instance = storage_api.StorageApi(api_client)
    # StorageStoragePolicy | The 'StorageStorage.Policy' resource to create.
    storage_pol = StorageStoragePolicy(name="sample_storage_policy")
    try:
        # Create a 'StorageStorage.Policy' resource.
        api_response = api_instance.create_storage_storage_policy(storage_pol)
        print(api_response)
    except intersight.ApiException as e:
        print("Exception when calling StorageApi->create_storage_storage_policy: %s\n" % e)
        sys.exit(1)


if __name__ == "__main__":
    # Trigger creation of storage policy
    create_storage_policy()
