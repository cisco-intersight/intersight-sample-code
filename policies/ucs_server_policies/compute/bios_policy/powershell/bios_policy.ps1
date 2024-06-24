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

# get oragnizationRef
$orgRef = $org | Get-IntersightMoMoRef

# create a bios policy
$result = New-IntersightBiosPolicy -Name "bios_policy_1" -IntelHyperThreadingTech Enabled -IntelTurboBoostTech Enabled `
         -EnhancedIntelSpeedStepTech Enabled -HardwarePrefetch Enabled -EnergyEfficientTurbo Disabled  -Organization $orgRef