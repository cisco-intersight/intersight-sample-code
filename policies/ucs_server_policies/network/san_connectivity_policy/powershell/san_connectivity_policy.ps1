# Set up intersight environment this action is required once per powershell session
$config = @{
        BasePath = "https://intersight.com"
        ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
        ApiKeyFilePath = "C:\\secretKey.txt"
        HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
    }
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

# get the VnicEthIf ref object if it exist otherwise create a new using New-IntersightVnicEthIf.
$fcIfRef2 = Get-IntersightVnicFcIf -Name "fc1" | Get-IntersightMoMoRef

$result = New-IntersightVnicSanConnectivityPolicy -Name "san_connectivity_policy_1" -PlacementMode Custom -TargetPlatform Standalone `
        -Organization $orgRef -WwnnAddressType POOL 