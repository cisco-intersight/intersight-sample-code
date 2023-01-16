#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef

$passwordProperty = Initialize-IntersightIamEndPointPasswordProperties -PasswordHistory 5 -EnforceStrongPassword $true -ForceSendPassword $true `
                    -GracePeriod 2 -NotificationPeriod 1

$result = New-IntersightIamEndPointUserPolicy -Name "user_policy_1" -PasswordProperties $passwordProperty -Organization $orgRef