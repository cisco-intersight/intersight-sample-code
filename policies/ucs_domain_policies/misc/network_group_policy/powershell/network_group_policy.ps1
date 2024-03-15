# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

# initialize vlan settings
$valnSetting = Initialize-IntersightFabricVlanSettings -AllowedVlans 14 -NativeVlan 14

$result = New-IntersightFabricEthNetworkGroupPolicy -Name "fabricEthNetorkGroupPolicy" -VlanSettings $valnSetting -Organization $orgRef