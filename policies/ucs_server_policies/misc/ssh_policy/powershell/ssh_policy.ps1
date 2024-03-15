# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$ssh_policy = New-IntersightSshPolicy -Name "ssh_policy_1" -Description "ssh policy" -Port 12000 -Timeout 1800 -Organization $orgRef