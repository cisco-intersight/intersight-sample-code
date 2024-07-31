# Provide intersight environment details
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration, this action needs to be performed once per PowerShell session
Set-IntersightConfiguration @config

# Get an organization . 
$org = Get-IntersightOrganizationOrganization -Name "default" 

# create a ntp policy
$ntpPolicy = New-IntersightNtpPolicy -Name "ntp_policy_11" -NtpServers @("22.22.22.33","44.44.44.44") -Enabled $true `
                -Organization $org 

# create a bios policy
$biosPolicy = New-IntersightBiosPolicy -Name "bios_policy_11" -BootOptionRetry Enabled -IntelTurboBoostTech Enabled `
                -Organization $org 

# create a kvm policy and get kvm policy
$kvmPolicy = New-IntersightKvmPolicy -Name "kvm_policy_11" -EnableLocalServerVideo $true -EnableVideoEncryption $true `
                -Enabled $true -Organization $org 

# create a ServerProfile template.
$result = New-IntersightServerProfileTemplate -Name "Server_Profile_template_1" `
          -PolicyBucket @($ntpPolicy,$biosPolicy,$kvmPolicy) -Organization $org
