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

# initialize vlan settings
$valnSetting = Initialize-IntersightFabricVlanSettings -AllowedVlans "11,12,13" -NativeVlan 1

# create a ethernet network group policy
$result = New-IntersightFabricEthNetworkGroupPolicy -Name "fabricEthNetorkPolicy" -VlanSettings $valnSetting -Organization $org