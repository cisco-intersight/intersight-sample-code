#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef

$solPolicy = New-IntersightSolPolicy -Name "sample_sol_policy" -BaudRate NUMBER_19200 -ComPort Com0 -Enabled $true -SshPort 21 -Organization $orgRef