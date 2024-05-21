# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# Get organization MoRef
$orgRef = Get-IntersightOrganizationOrganization -Name "default" | Get-IntersightMoMoRef

# get the policies MoRef for domain profile.
$ethNetworkRef = Get-IntersightFabricEthNetworkPolicy -Name "eth_network_policy_1" | Get-IntersightMoMoRef
$fcNetworkRef = Get-IntersightFabricFcNetworkPolicy -Name "fc_network_policy_1" | Get-IntersightMoMoRef
$portRef = Get-IntersightFabricPortPolicy -Name "port_policy_1" | Get-IntersightMoMoRef
$systemQoSRef = Get-IntersightFabricSystemQosPolicy -Name "system_qos_policy_1" | Get-IntersightMoMoRef
$switchControlRef = Get-IntersightFabricSwitchControlPolicy -Name "switch_control_policy_1" | Get-IntersightMoMoRef
$ntpRef = Get-IntersightNtpPolicy -Name  "ntp_policy_1" | Get-IntersightMoMoRef
$syslogRef = Get-IntersightSyslogPolicy -Name "syslog_policy_1" | Get-IntersightMoMoRef
$networkConfigRef = Get-IntersightNetworkconfigPolicy -Name "network_config_policy_1" | Get-IntersightMoMoRef
$snmpRef =  Get-IntersightSnmpPolicy -Name "snmp_policy_1" | Get-IntersightMoMoRef

# create a domain profile for Fabric switch A
$fabric_A_Prfile = New-IntersightFabricSwitchProfile -Name "Fabric_A_profile" `
                   -PolicyBucket @($ethNetworkRef,$fcNetworkRef,$PortRef,$systemQoSRef,$switchControlRef,$ntpRef,$syslogRef,$snmpRef,$networkConfigRef)

# create a domain profile for fabric switch B
$fabric_B_Profile = New-IntersightFabricSwitchProfile -Name "Fabric_B_profile" `
                    -PolicyBucket @($ethNetworkRef,$fcNetworkRef,$PortRef,$systemQoSRef,$switchControlRef,$ntpRef,$syslogRef,$snmpRef,$networkConfigRef)

# create cluster switch policy
$fabric_A_ProfileRef = $fabric_A_Prfile | Get-IntersightMoMoRef
$fabric_B_ProfileRef = $fabric_B_Profile | Get-IntersightMoMoRef
$clusterSiwtchPolicy = New-IntersightFabricSwitchClusterProfile -Name "cluster_switch_profile_1" -Organization $orgRef `
                       -SwitchProfiles @($fabric_A_ProfileRef,$fabric_B_ProfileRef)