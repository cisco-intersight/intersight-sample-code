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
$org = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

# get organizationRef
$orgRef = $org | Get-IntersightMoMoRef

# create a IPMI over LAN policy
$result = New-IntersightIpmioverlanPolicy -Name "ipmi_over_lan_1" -Enabled $true -Privilege Admin -Organization $orgRef -EncryptionKey "FFFFAAAA99990006752896ABCDED"