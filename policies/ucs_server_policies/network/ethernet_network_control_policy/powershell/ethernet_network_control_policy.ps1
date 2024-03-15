# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$lldpSetting = Initialize-IntersightFabricLldpSettings -ReceiveEnabled $true -TransmitEnabled $true

$Result = New-IntersightFabricEthNetworkControlPolicy -Name "eth_network_control_policy_1" -ForgeMac Allow -MacRegistrationMode NativeVlanOnly `
        -CdpEnabled $true -UplinkFailAction LinkDown -LldpSettings $lldpSetting -Organization $orgRef