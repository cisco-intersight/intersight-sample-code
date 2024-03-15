#Get the organization under which the policy should be created.
$newOrg = Get-IntersightOrganizationOrganization -Name default

$kvmPolicy = New-IntersightKvmPolicy -Name PSKvm -Description "Kvm policy for PSOrg" `
                                    -EnableVideoEncryption $true -EnableLocalServerVideo $true `
                                    -Enabled $true -MaximumSessions 2 -Organization $newOrg