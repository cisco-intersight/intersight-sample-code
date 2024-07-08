# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 

# initialize vmedia mapping 
$vmediaMapping = Initialize-IntersightVmediaMapping -AuthenticationProtocol None -DeviceType Cdd -FileLocation "nfs://10.193.167.6/exports/vms/ucs-c240m5-huu-3.1.3h.iso"`
                -HostName "12.11.11.13" -MountProtocol Nfs  -VolumeName v0
# create a new vmedia policy by passing the above created vmedia mapping
$result = New-IntersightVmediaPolicy -Name "vmedia_policy_1" -Enabled $true -Encryption $true -Mappings @($vmediaMapping) -LowPowerUsb $true -Organization $org
