# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

# initialize vlan settings
$valnSetting = Initialize-IntersightFabricVlanSettings -AllowedVlans 14 -NativeVlan 14

$result = New-IntersightFabricEthNetworkGroupPolicy -Name "fabricEthNetorkGroupPolicy" -VlanSettings $valnSetting -Organization $orgRef