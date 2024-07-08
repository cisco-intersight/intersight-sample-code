# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization.
$org = Get-IntersightOrganizationOrganization -Name default

# create a kvm policy
$kvmPolicy = New-IntersightKvmPolicy -Name "kvm_policy_1" -Description "Kvm policy for sample" `
                                    -EnableVideoEncryption $true -EnableLocalServerVideo $true `
                                    -Enabled $true -MaximumSessions 2 -Organization $org