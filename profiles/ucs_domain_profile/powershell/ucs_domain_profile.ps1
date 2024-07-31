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
$org = Get-IntersightOrganizationOrganization -Name "default" 

# get the domain profile policies.
$ethNetwork = Get-IntersightFabricEthNetworkPolicy -Name "eth_network_policy_1" 
$fcNetwork = Get-IntersightFabricFcNetworkPolicy -Name "fc_network_policy_1" 
$port = Get-IntersightFabricPortPolicy -Name "port_policy_1" 
$systemQoS = Get-IntersightFabricSystemQosPolicy -Name "system_qos_policy_1" 
$switchControl = Get-IntersightFabricSwitchControlPolicy -Name "switch_control_policy_1" 
$ntp = Get-IntersightNtpPolicy -Name  "ntp_policy_1" 
$syslog = Get-IntersightSyslogPolicy -Name "syslog_policy_1" 
$networkConfig = Get-IntersightNetworkconfigPolicy -Name "network_config_policy_1" 
$snmp =  Get-IntersightSnmpPolicy -Name "snmp_policy_1" 

# create a domain profile for Fabric switch A
$fabric_A_Prfile = New-IntersightFabricSwitchProfile -Name "Fabric_A_profile" `
                   -PolicyBucket @($ethNetwork,$fcNetwork,$Port,$systemQoS,$switchControl,$ntp,$syslog,$snmp,$networkConfig)

# create a domain profile for fabric switch B
$fabric_B_Profile = New-IntersightFabricSwitchProfile -Name "Fabric_B_profile" `
                    -PolicyBucket @($ethNetwork,$fcNetwork,$Port,$systemQoS,$switchControl,$ntpRef,$syslog,$snmp,$networkConfig)

$clusterSiwtchPolicy = New-IntersightFabricSwitchClusterProfile -Name "cluster_switch_profile_1" -Organization $org `
                       -SwitchProfiles @($fabric_A_Prfile,$fabric_B_Profile)