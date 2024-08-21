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

$qosSilver = Initialize-IntersightFabricQosClass -AdminState Enabled -BandwidthPercent 15 -Name Silver -PacketDrop $true -Weight 7 -Mtu 1500 -Cos 1

$qosBronze = Initialize-IntersightFabricQosClass -Name Bronze -AdminState Enabled -BandwidthPercent 18 -Weight 8 -Mtu 1500 -Cos 2

$qoSGold = Initialize-IntersightFabricQosClass -Name Gold -Weight 9 -BandwidthPercent 20 -AdminState Enabled -PacketDrop $true -Mtu 1500 -Cos 4

$qosPlatinum = Initialize-IntersightFabricQosClass -Name Platinum -AdminState Enabled -BandwidthPercent 22 -Cos 5 -Mtu 1500 -Weight 10 -PacketDrop $true

$qosPolicy = New-IntersightFabricSystemQosPolicy -Name "qos_policy_1" -Classes @($qosPlatinum,$qoSGold,$qosSilver,$qosBronze) -Organization $org