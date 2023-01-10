# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightNtpPolicy -Name "ntp_policy_1" -Enabled $true -NtpServers @("44.44.44.44") -Organization $orgRef