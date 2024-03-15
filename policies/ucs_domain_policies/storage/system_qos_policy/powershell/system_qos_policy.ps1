# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$qosSilver = Initialize-IntersightFabricQosClass -AdminState Enabled -BandwidthPercent 15 -Name Silver -PacketDrop $true -Weight 7 -Mtu 1500 -Cos 1

$qosBronze = Initialize-IntersightFabricQosClass -Name Bronze -AdminState Enabled -BandwidthPercent 18 -Weight 8 -Mtu 1500 -Cos 2

$qoSGold = Initialize-IntersightFabricQosClass -Name Gold -Weight 9 -BandwidthPercent 20 -AdminState Enabled -PacketDrop $true -Mtu 1500 -Cos 4

$qosPlatinum = Initialize-IntersightFabricQosClass -Name Platinum -AdminState Enabled -BandwidthPercent 22 -Cos 5 -Mtu 1500 -Weight 10 -PacketDrop $true


$qosPolicy = New-IntersightFabricSystemQosPolicy -Name "qos_policy_1" -Classes @($qosPlatinum,$qoSGold,$qosSilver,$qosBronze) -Organization $orgRef