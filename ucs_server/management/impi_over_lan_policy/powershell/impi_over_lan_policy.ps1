#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef

$result = New-IntersightIpmioverlanPolicy -Name "ipmi_over_lan_1" -Enabled $true -Privilege Admin -Organization $orgRef -EncryptionKey "FFFFAAAA99990000xxxxxxxxxxxxxxx"