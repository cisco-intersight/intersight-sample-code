#Get the organization under which the policy should be created.

$newOrg = Get-IntersightOrganizationOrganization -Name default

$ntpPolicy = New-IntersightNtpPolicy -Name "PSNtp" -Description "ntp policy for PSOrg" `
                                     -NtpServers @("22.22.22.22","77.77.77.77") `
                                     -Enabled $true -Timezone IndianMauritius -Organization $newOrg