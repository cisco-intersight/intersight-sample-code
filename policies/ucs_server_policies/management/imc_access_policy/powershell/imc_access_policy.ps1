#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef

$addressType = Initialize-IntersightAccessAddressType -EnableIpV4 $true -EnableIpV6 $false

$configurationType = Initialize-IntersightAccessConfigurationType -ConfigureInband $true -ConfigureOutOfBand $false

# get the existing Ipv4_pool if already created, otherwise create New Ippool using New-IntersightIppoolPool
$ipoolRef = Get-IntersightIppoolPool -Name "Ipv4_pool" | Get-IntersightMoMoRef

$result = New-IntersightAccessPolicy -Name "access_policy_1" -AddressType $addressType -ConfigurationType $configurationType `
    -InbandIpPool $ipoolRef -Organization $orgRef -InbandVlan 144