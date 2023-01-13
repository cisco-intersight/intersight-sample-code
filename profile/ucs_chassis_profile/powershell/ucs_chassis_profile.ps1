#get the Org Ref if it exist, else create a new organizarion using New-IntersightOrganizationOrganization

$orgRef = Get-IntersightOrganizationOrganization -Name "<Name of Org>" | Get-IntersightMoMoRef

$result = New-IntersightChassisProfile -Name "chassis_profile_1" -Description "sample chassis profile" -TargetPlatform FIAttached `
            -Organization $orgRef