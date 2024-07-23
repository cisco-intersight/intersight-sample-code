# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# ger organization MoRef
$org = Get-IntersightOrganizationOrganization -Name default 

#initialize MAC pool bock
$macPoolBlock = Initialize-IntersightMacpoolBlock -From "00:25:B5:00:00:01" -Size 10

#create MAC pool
$result = New-IntersightMacpoolPool -Name "MAC_pool_1" -AssignmentOrder Sequential -MacBlocks $macPoolBlock -Organization $org
