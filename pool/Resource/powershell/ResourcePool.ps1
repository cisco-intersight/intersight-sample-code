# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# get organization ref
$org = Get-IntersightOrganizationOrganization -Name default 

# initialize resource pool parameter
$ResourcePoolParameters1 = Initialize-IntersightResourcepoolServerPoolParameters -ManagementMode "IntersightStandalone"

# resource selector
$resourceSelector = Initialize-IntersightResourceSelector -Selector "/api/v1/compute/RackUnits?`$filter=(Serial eq 'EMEDDEC6E0')"

 $result = New-IntersightResourcepoolPool -Name "Resource_pool_1" -AssignmentOrder Sequential -PoolType Static `
           -Organization $org  -Selectors $resourceSelector -ResourcePoolParameters $ResourcePoolParameters1