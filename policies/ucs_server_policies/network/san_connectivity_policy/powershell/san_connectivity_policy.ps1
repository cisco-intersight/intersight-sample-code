# Provide intersight environment details
$config = @{
        BasePath = "https://intersight.com"
        ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
        ApiKeyFilePath = "C:\\secretKey.txt"
        HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
    }
# set intersight configuration, this action needs to be performed once per PowerShell session
Set-IntersightConfiguration @config

# Get an Organization.
$org = Get-IntersightOrganizationOrganization -Name default 

# get the VnicEthIf ref object if it exist otherwise create a new using New-IntersightVnicEthIf.
$fcIfRef2 = Get-IntersightVnicFcIf -Name "fc1" 

$result = New-IntersightVnicSanConnectivityPolicy -Name "san_connectivity_policy_1" -PlacementMode Custom -TargetPlatform Standalone `
        -Organization $org -WwnnAddressType POOL 