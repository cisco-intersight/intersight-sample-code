# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightFabricPortPolicy -Name "port_policy_1" -DeviceModel UCSFI64108 -Organization $orgRef