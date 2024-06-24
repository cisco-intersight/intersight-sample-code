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
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

# initialize IPv4 config
$ipv4Config = Initialize-IntersightIppoolIpV4Config -Gateway "10.108.190.1" -Netmask "255.255.255.0" -PrimaryDns "10.108.190.100"

# initialize Ipv4 block
$IPv4Block = Initialize-IntersightIppoolIpV4Block -From "10.108.190.11" -To "10.108.190.20"

# create IPpool
$result = New-IntersightIppoolPool -Name IpPool_1 -IpV4Blocks @($IPv4Block) -IpV4Config $ipv4Config -Organization $orgRef