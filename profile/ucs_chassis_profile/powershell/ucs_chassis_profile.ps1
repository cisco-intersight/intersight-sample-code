# get the Organization ref, If otganization does not exist use the cmdlet New-IntersightOrganizationOrganization to create it.
$orgRef = Get-IntersightOrganizationOrganization -Name "default" | Get-IntersightMoMoRef

New-IntersightChassisProfile -Name "sample_chassis_profile_1" -Organization $orgRef