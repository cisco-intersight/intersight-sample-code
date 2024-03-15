# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$vlanSetting = Initialize-IntersightVnicVlanSettings -DefaultVlan 122 -Mode TRUNK

$result = New-IntersightVnicEthNetworkPolicy -Name "vnic_eth_network_poicy_1" -VlanSettings $vlanSetting -TargetPlatform Standalone `
            -Organization $orgRef