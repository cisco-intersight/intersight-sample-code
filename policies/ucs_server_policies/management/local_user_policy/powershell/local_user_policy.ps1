# Create a user named guest and assigned admin role to it.
# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 

# create a user name guest.
$user = New-IntersightIamEndPointUser -Name guest -Organization $org

# initialize password properties to create policy and assign  the policy to User Policy
$passwordProperty = Initialize-IntersightIamEndPointPasswordProperties -PasswordHistory 5 -EnforceStrongPassword $true -ForceSendPassword $true `
                    -GracePeriod 2 -NotificationPeriod 1
# create a user policy
$userPolicy = New-IntersightIamEndPointUserPolicy -Name "user_policy_1" -PasswordProperties $passwordProperty -Organization $org 

# get admin role ref which will be assigned to above created user
$adminRole = Get-IntersightIamEndPointRole -Name "admin" 

# create endpoint userRole
$endPointUserRole = New-IntersightIamEndPointUserRole -Enabled $true -EndPointRole $adminRole -Password "admin@1234" `
                       -EndPointUser $user  -EndPointUserPolicy $userPolicy 