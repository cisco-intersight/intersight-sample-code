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

# initialize FC pool block
$fcBlocks = Initialize-IntersightFcpoolBlock -From "20:00:00:25:B5:00:00:01" -Size 100 

# create WWNN pool
$result = New-IntersightFcpoolPool -Name "wwnn_pool_1" -AssignmentOrder "Default" -IdBlocks @($fcBlocks) -PoolPurpose "WWNN" `
          -Organization $org