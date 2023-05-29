# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMOMORef

$multiCastPolicy = New-IntersightFabricMulticastPolicy -Name "fabricMultiCastPolicy" -QuerierState Enabled -SnoopingState Enabled -QuerierIpAddress "11.11.11.11"`
            -Organization $orgRef

$multiCastRef = $multiCastPolicy | Get-IntersightMoMoRef

$EthNetwrkPolicy = New-IntersightFabricEthNetworkPolicy -Name "netwrkPolicy" -Organization $orgRef -Description "native network policy"

$ethNetworkPolicyRef = $EthNetwrkPolicy | Get-IntersightMoMoRef

$result = New-IntersightFabricVlan -Name "valn_policy" -AutoAllowOnUplinks $false -EthNetworkPolicy $ethNetworkPolicyRef -MulticastPolicy $multiCastRef `
            -IsNative $false -VlanId 2323


