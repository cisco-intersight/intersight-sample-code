# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# Get a organization ref. 
$orgRef = Get-IntersightOrganizationOrganization -Name "default" | Get-IntersightMoMoRef

# create ntp policy and get MoRef
$ntpPolicyRef = New-IntersightNtpPolicy -Name "ntp_policy_11" -NtpServers @("22.22.22.33","44.44.44.44") -Enabled $true `
                -Organization $orgRef | Get-IntersightMoMoRef

# create bios policy and get MoRef
$biosPolicyRef = New-IntersightBiosPolicy -Name "bios_policy_11" -BootOptionRetry Enabled -IntelTurboBoostTech Enabled `
                -Organization $orgRef | Get-IntersightMoMoRef

# create kvm policy and get kvm policy
$kvmPolicyRef = New-IntersightKvmPolicy -Name "kvm_policy_11" -EnableLocalServerVideo $true -EnableVideoEncryption $true `
                -Enabled $true -Organization $orgRef | Get-IntersightMoMoRef

# create a ServerProfile template.
$result = New-IntersightServerProfileTemplate -Name "Server_Profile_template_1" `
          -PolicyBucket @($ntpPolicyRef,$biosPolicyRef,$kvmPolicyRef) -Organization $orgRef
