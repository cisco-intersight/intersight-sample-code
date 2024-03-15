# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightDeviceconnectorPolicy -Name "device_connector_policy_1" -LockoutEnabled $true -Organization $orgRef