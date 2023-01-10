#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef

$result = New-IntersightBiosPolicy -Name "bios_policy_1" -IntelHyperThreadingTech Enabled -IntelTurboBoostTech Enabled -Organization $orgRef