# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

# get the VnicEthIf ref object.
$ethIfRef = Get-IntersightVnicEthIf -Name "eth0" | Get-IntersightMoMoRef

$result = New-IntersightVnicLanConnectivityPolicy -Name "lan_connectivity_policy_1" -IqnAllocationType None -PlacementMode Custom -TargetPlatform Standalone `
        -Organization $orgRef -AzureQosEnabled $false -EthIfs @($ethIfRef)