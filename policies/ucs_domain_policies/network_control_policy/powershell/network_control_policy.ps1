# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization.
$org = Get-IntersightOrganizationOrganization -Name default 

# initialize vlan settings
$vlanSetting = Initialize-IntersightVnicVlanSettings -AllowedVlans "11-19" -DefaultVlan 11 -Mode ACCESS

# create ethNetwork policy and get ref of it
$network = New-IntersightvnicEthNetworkPolicy -name "vnic_eth_network_policy_1" -TargetPlatform FIAttached `
              -VlanSettings $vlanSetting -Organization $org 

$lldpSetting = Initialize-IntersightFabricLldpSettings -ReceiveEnabled $true -TransmitEnabled $true

$result = New-IntersightFabricEthNetworkControlPolicy -Name "networkControlPolicy" -CdpEnabled $true `
          -UplinkFailAction Warning -MacRegistrationMode NativeVlanOnly -ForgeMac Allow `
          -LldpSettings $lldpSetting -NetworkPolicy $network -Organization $org
        