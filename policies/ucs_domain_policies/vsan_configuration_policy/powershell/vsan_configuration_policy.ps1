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

# create a new network policy or get the existing one using Get-IntersightFabricFcNetworkPolicy
$fcNetworkPolicy = New-IntersightFabricFcNetworkPolicy -Name "fc_network_policy_1" -EnableTrunking $false -Organization $org

$vsanPolicy = New-IntersightFabricVsan -Name "vsan_110" -DefaultZoning Disabled -VsanScope Uplink -FcoeVlan 1120 -VsanId 110 -FcNetworkPolicy $fcNetworkPolicy

