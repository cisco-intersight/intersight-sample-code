# Provide intersight environment details
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration, this action needs to be performed once per PowerShell session
Set-IntersightConfiguration @config

# Get an Organization.
$org = Get-IntersightOrganizationOrganization -Name default

$multiCastPolicy = New-IntersightFabricMulticastPolicy -Name "fabricMultiCastPolicy" -QuerierState Enabled `
                 -SnoopingState Enabled -QuerierIpAddress "11.11.11.11" -Organization $org

$EthNetwrkPolicy = New-IntersightFabricEthNetworkPolicy -Name "netwrkPolicy" -Organization $org -Description "native network policy"

$result = New-IntersightFabricVlan -Name "valn_23" -AutoAllowOnUplinks $false -EthNetworkPolicy $EthNetwrkPolicy `
          -MulticastPolicy $multiCastPolicy -IsNative $false -VlanId 23