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

$addressType = Initialize-IntersightAccessAddressType -EnableIpV4 $true -EnableIpV6 $false

$configurationType = Initialize-IntersightAccessConfigurationType -ConfigureInband $true -ConfigureOutOfBand $false

# get the existing Ipv4_pool if already created 
# $ipPool = Get-IntersightIppoolPool -Name "Ipv4_pool" 

# create New IP pool using New-IntersightIppoolPool
$ipv4Block = Initialize-IntersightIppoolIpV4Block -From "10.128.130.100" -Size 10

$ipv4Config = Initialize-IntersightIppoolIpV4Config -Gateway "10.128.130.254" -Netmask "255.255.255.0"

$ipv4Pool = New-IntersightIppoolPool -Name "ipv4_ippool_1" -AssignmentOrder Default -IpV4Blocks $ipv4Block -IpV4Config $ipv4Config -Organization $org

# create a access policy
$result = New-IntersightAccessPolicy -Name "access_policy_1" -AddressType $addressType -ConfigurationType $configurationType `
          -InbandIpPool $ipv4Pool -Organization $org -InbandVlan 144