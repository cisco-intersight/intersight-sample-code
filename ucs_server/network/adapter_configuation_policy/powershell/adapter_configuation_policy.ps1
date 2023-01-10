# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$ethSetting = Initialize-IntersightAdapterEthSettings -LldpEnabled $true

$fcsetting = Initialize-IntersightAdapterFcSettings -FipEnabled $true

$portChannelSetting = Initialize-IntersightAdapterPortChannelSettings -Enabled $true

$dceInterfaceSetting = Initialize-IntersightAdapterDceInterfaceSettings -FecMode Cl91 -InterfaceId 1

$adapterConfig = Initialize-IntersightAdapterAdapterConfig -DceInterfaceSettings @($dceInterfaceSetting) -EthSettings $ethSetting `
                    -FcSettings $fcsetting -PortChannelSettings $portChannelSetting -SlotId MLOM

$result = New-IntersightAdapterConfigPolicy -Name "adapter_config_policy" -Settings @($adapterConfig) -Organization $orgRef