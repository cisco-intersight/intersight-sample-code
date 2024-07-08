# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization.
$org = Get-IntersightOrganizationOrganization -Name default 

$m2VirtualDrive = Initialize-IntersightStorageM2VirtualDriveConfig -Enable $true -ControllerSlot MSTORRAID1

$virtualDrivePolicy = Initialize-IntersightStorageVirtualDrivePolicy -DriveCache Default -ReadPolicy Default -StripSize NUMBER_512 -AccessPolicy Default

$raid0Drive = Initialize-IntersightStorageR0Drive -Enable $true -VirtualDrivePolicy $virtualDrivePolicy

$result = New-IntersightStorageStoragePolicy -Name "storage_policy_1" -Organization $org -DefaultDriveMode RAID0 `
             -M2VirtualDrive $m2VirtualDrive -Raid0Drive $raid0Drive