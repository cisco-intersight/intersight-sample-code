# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$networkRef = GET-IntersightvnicEthNetworkPolicy -name "<NameOfthePolicy>" | Get-IntersightMoMoRef
$lldpSetting = Initialize-IntersightFabricLldpSettings -ReceiveEnabled $true -TransmitEnabled $true


$result = New-IntersightFabricEthNetworkControlPolicy -Name "networkControlPolicy" -CdpEnabled $true -UplinkFailAction Warning -MacRegistrationMode NativeVlanOnly `
        -ForgeMac Allow -LldpSettings $lldpSetting -NetworkPolicy $networkRef -Organization $orgRef
        