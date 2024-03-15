# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

# get the VnicEthIf ref object.
$fcIfRef = Get-IntersightVnicFcIf -Name "fc1" | Get-IntersightMoMoRef

$result = New-IntersightVnicSanConnectivityPolicy -Name "san_connectivity_policy_1" -PlacementMode Custom -TargetPlatform Standalone `
        -Organization $orgRef -WwnnAddressType POOL -FcIfs @($fcIfRef)