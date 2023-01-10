# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$fcNetworkPolicy = New-IntersightFabricFcNetworkPolicy -Name "fc_network_policy_1" -EnableTrunking $false -Organization $orgRef

$fcNetworkPolicyRef = $fcNetworkPolicy | Get-IntersightMoMoRef

$vsanPolicy = New-IntersightFabricVsan -Name "vsan_1" -DefaultZoning Disabled -VsanScope Uplink -FcoeVlan 3646 -VsanId 3646 -FcNetworkPolicy $fcNetworkPolicyRef

