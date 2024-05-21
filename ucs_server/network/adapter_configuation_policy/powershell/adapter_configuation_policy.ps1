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

$ethSetting = Initialize-IntersightAdapterEthSettings -LldpEnabled $true

$fcsetting = Initialize-IntersightAdapterFcSettings -FipEnabled $true

$portChannelSetting = Initialize-IntersightAdapterPortChannelSettings -Enabled $true

$dceInterfaceSetting = Initialize-IntersightAdapterDceInterfaceSettings -FecMode Cl91 -InterfaceId 1

$adapterConfig = Initialize-IntersightAdapterAdapterConfig -DceInterfaceSettings @($dceInterfaceSetting) -EthSettings $ethSetting `
                    -FcSettings $fcsetting -PortChannelSettings $portChannelSetting -SlotId MLOM

# create a adapter config policy
$result = New-IntersightAdapterConfigPolicy -Name "adapter_config_policy" -Settings @($adapterConfig) -Organization $orgRef