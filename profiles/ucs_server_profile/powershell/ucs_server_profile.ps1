# Provide intersight environment details
$config = @{
    BasePath          = "https://intersight.com"
    ApiKeyId          = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath    = "C:\\secretKey.txt"
    HttpSigningHeader = @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration, this action needs to be performed once per PowerShell session
Set-IntersightConfiguration @config

# Get an organization
$org = Get-IntersightOrganizationOrganization -Name default

# Creating NTP policy
$ntp = New-IntersightNtpPolicy -Organization $org -Name 'ntp1' -Description 'test policy' -Enabled 1 `
    -NtpServers @('ntp.esl.cisco.com', 'time-a-g.nist.gov', 'time-b-g.nist.gov') 

# Creating SMTP policy
$smtp = New-IntersightSmtpPolicy -Organization $org -Enabled 0 -Name 'smtp1' -Description 'testing smtp policy' `
    -SmtpPort 32 -MinSeverity 'critical' -SmtpServer '10.10.10.1' -SenderEmail 'IMCSQAAutomation@cisco.com' `
    -SmtpRecipients @('aw@cisco.com', 'cy@cisco.com', 'dz@cisco.com') 

# Creating SNMP policy
$snmp_users1 = Initialize-IntersightSnmpUser -Name 'demouser' -PrivacyType 'AES' -SecurityLevel 'AuthPriv' -AuthType 'SHA' -AuthPassword 'dummyPassword' -PrivacyPassword 'dummyPrivatePassword'
$snmp_traps1 = Initialize-IntersightSnmpTrap -Destination '10.10.10.1' -Enabled 0 -Type 'Trap' -User 'demouser' -Port 660 -ObjectType 'SnmpTrap' -Version 'V3'
$snmp = New-IntersightSnmpPolicy -Name 'snmp1' -Description 'testing smtp policy' -Enabled 1 -SnmpPort 1983 `
    -SnmpUsers $snmp_users1 -SnmpTraps $snmp_traps1 -Organization $org -AccessCommunityString 'dummy123' `
    -CommunityAccess 'Disabled' -TrapCommunity 'TrapCommunity' -SysContact 'xyz' -SysLocation 'SJC' -EngineId 'abc' `
         


# Create a server profile Tag
$tags1 = Initialize-IntersightMoTag -Key 'server' -Value 'demo'

# create a server profile
$serverProfile = New-IntersightServerProfile -Name "server_profile1" -Description "A sample server profile"  -Organization $org `
    -Tags $tags1 -TargetPlatform "Standalone" -PolicyBucket @($ntp, $smtp, $snmp) `
                            
# assigned server profile to a server. Get the RackUnit or BladeUnit MoRef
$server = Get-IntersightComputeRackunit -Moid '<Replace with Moid>' 
$serverProfile | Set-IntersightServerProfile -AssignedServer $server

# deploy server profile to assigned server.
$serverProfile | Set-IntersightServerProfile -Action 'Deploy'
