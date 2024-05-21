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
$organization1 = Get-IntersightOrganizationOrganization -Name 'default' | Get-IntersightMoMoRef

# create ntp, smtp and smnp policies for server profile

# Creating NTP policy and get MoRef
$ntpRef = New-IntersightNtpPolicy -Organization $organization1 -Name 'ntp1' -Description 'test policy' -Enabled 1 `
        -NtpServers @('ntp.esl.cisco.com', 'time-a-g.nist.gov', 'time-b-g.nist.gov') | Get-IntersightMoMoRef

# Creating SMTP policy and get MoRef
$smtpRef = New-IntersightSmtpPolicy -Organization $organization1 -Enabled 0 -Name 'smtp1' -Description 'testing smtp policy' `
         -SmtpPort 32 -MinSeverity 'critical' -SmtpServer '10.10.10.1' -SenderEmail 'IMCSQAAutomation@cisco.com' `
         -SmtpRecipients @('aw@cisco.com', 'cy@cisco.com', 'dz@cisco.com') | Get-IntersightMoMoRef

# Creating SNMP policy and get MoRef
$snmp_users1 = Initialize-IntersightSnmpUser -Name 'demouser' -PrivacyType 'AES' -SecurityLevel 'AuthPriv' -AuthType 'SHA' -AuthPassword 'dummyPassword' -PrivacyPassword 'dummyPrivatePassword'
$snmp_traps1 = Initialize-IntersightSnmpTrap -Destination '10.10.10.1' -Enabled 0 -Type 'Trap' -User 'demouser' -Port 660 -ObjectType 'SnmpTrap' -Version 'V3'
$snmpRef = New-IntersightSnmpPolicy -Name 'snmp1' -Description 'testing smtp policy' -Enabled 1 -SnmpPort 1983 `
         -SnmpUsers $snmp_users1 -SnmpTraps $snmp_traps1 -Organization $organization1 -AccessCommunityString 'dummy123' `
         -CommunityAccess 'Disabled' -TrapCommunity 'TrapCommunity' -SysContact 'xyz' -SysLocation 'SJC' -EngineId 'abc' `
         | Get-IntersightMoMoRef


# Create a server profile Tag
$tags1 = Initialize-IntersightMoTag -Key 'server' -Value 'demo'

# create a server profile
$serverProfile = New-IntersightServerProfile -Name "ss_server_profile1" -Description "A sample server profile"  -Organization $Organization1 `
                            -Tags $tags1 -TargetPlatform "Standalone" -PolicyBucket @($ntpRef, $smtpRef, $snmpRef) `
                            
# assigned server profile to a server. Get the RackUnit or BladeUnit MoRef
$serverRef = Get-IntersightComputeRackunit -Moid '<Replace with Moid>' | Get-IntersightMoMoRef
$serverProfile | Set-IntersightServerProfile -AssignedServer $serverRef

# deploy server profile to assigned server.
$serverProfile | Set-IntersightServerProfile -Action 'Deploy'
