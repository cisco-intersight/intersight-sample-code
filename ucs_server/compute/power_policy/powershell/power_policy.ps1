#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef

$result = New-IntersightPowerPolicy -Name "power_policy_1" -DynamicRebalancing Disabled -ExtendedPowerCapacity Enabled -PowerPriority Low `
                -PowerProfiling Enabled -PowerRestoreState AlwaysOff -PowerSaveMode Enabled -RedundancyMode Grid -Organization $orgRef