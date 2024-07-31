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

# initialize vlan settings
$vlanSetting = Initialize-IntersightVnicVlanSettings -AllowedVlans "21-30" -DefaultVlan 21 -Mode ACCESS

$lldpSetting = Initialize-IntersightFabricLldpSettings -ReceiveEnabled $true -TransmitEnabled $true

# create a fabric.EthNetworkControlPolicy with above created network setting
$Result = New-IntersightFabricEthNetworkControlPolicy -Name "eth_network_control_policy_1" -ForgeMac Allow `
         -MacRegistrationMode NativeVlanOnly -CdpEnabled $true -UplinkFailAction LinkDown `
         -LldpSettings $lldpSetting -Organization $org