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
$org = Get-IntersightOrganizationOrganization -Name "default" 

# create ntp policy and get MoRef
$ntpPolicy = New-IntersightNtpPolicy -Name "ntp_policy_11" -NtpServers @("22.22.22.33","44.44.44.44") -Enabled $true `
                -Organization $org 

# create bios policy and get MoRef
$biosPolicy = New-IntersightBiosPolicy -Name "bios_policy_11" -BootOptionRetry Enabled -IntelTurboBoostTech Enabled `
                -Organization $org 

# create kvm policy and get kvm policy
$kvmPolicy = New-IntersightKvmPolicy -Name "kvm_policy_11" -EnableLocalServerVideo $true -EnableVideoEncryption $true `
                -Enabled $true -Organization $org 

# create a ServerProfile template.
$result = New-IntersightServerProfileTemplate -Name "Server_Profile_template_1" `
          -PolicyBucket @($ntpPolicy,$biosPolicy,$kvmPolicy) -Organization $org
