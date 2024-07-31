# Provide intersight environment details
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration, this action needs to be performed once per PowerShell session
Set-IntersightConfiguration @config

# Get an organization
$org = Get-IntersightOrganizationOrganization -Name default 

# initialize UUID block 
$UuidSuffixBlocks11 = Initialize-IntersightUuidpoolUuidBlock -From "0000-001234500A00" -Size 100

# create UUID pool
$result = New-IntersightUuidpoolPool -Name "uuuid_pool_1" -Prefix "00000000-0000-00A0"  -UuidSuffixBlocks @($UuidSuffixBlocks11) `
       -AssignmentOrder "Default" -Organization $org