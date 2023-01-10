# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$vsanSetting = Initialize-IntersightVnicVsanSettings -DefaultVlanId 0 -Id 1

$result = New-IntersightVnicFcNetworkPolicy -Name "fc_network_policy_1" -Organization $orgRef -VsanSettings $vsanSetting