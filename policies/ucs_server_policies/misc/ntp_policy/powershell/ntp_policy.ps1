# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

#Get torganization ref if it is exist, or create a new organization using New-IntersightOrganizationOrganization
$org = Get-IntersightOrganizationOrganization -Name default 

$ntpPolicy = New-IntersightNtpPolicy -Name "PSNtp" -Description "ntp policy for PSOrg" `
                                     -NtpServers @("22.22.22.22","77.77.77.77") `
                                     -Enabled $true -Timezone IndianMauritius -Organization $org