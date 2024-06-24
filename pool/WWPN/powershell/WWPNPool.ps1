# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# get organization MoRef
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

# initialize FC pool block
$fcPoolBlocks = Initialize-IntersightFcpoolBlock -From "20:00:00:25:B5:00:10:00" -Size 100

# create WWPN pool
$result = New-IntersightFcpoolPool -Name "wwpn_pool_1" -PoolPurpose "WWPN" -IdBlocks @($fcPoolBlocks)`
          -AssignmentOrder "Default" -Organization $orgRef