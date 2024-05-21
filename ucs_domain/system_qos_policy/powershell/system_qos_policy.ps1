# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

$qosSilver = Initialize-IntersightFabricQosClass -AdminState Enabled -BandwidthPercent 15 -Name Silver -PacketDrop $true -Weight 7 -Mtu 1500 -Cos 1

$qosBronze = Initialize-IntersightFabricQosClass -Name Bronze -AdminState Enabled -BandwidthPercent 18 -Weight 8 -Mtu 1500 -Cos 2

$qoSGold = Initialize-IntersightFabricQosClass -Name Gold -Weight 9 -BandwidthPercent 20 -AdminState Enabled -PacketDrop $true -Mtu 1500 -Cos 4

$qosPlatinum = Initialize-IntersightFabricQosClass -Name Platinum -AdminState Enabled -BandwidthPercent 22 -Cos 5 -Mtu 1500 -Weight 10 -PacketDrop $true

$qosPolicy = New-IntersightFabricSystemQosPolicy -Name "qos_policy_1" -Classes @($qosPlatinum,$qoSGold,$qosSilver,$qosBronze) -Organization $orgRef