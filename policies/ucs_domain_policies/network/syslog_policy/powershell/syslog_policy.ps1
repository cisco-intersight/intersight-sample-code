# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$localClient = Initialize-IntersightSyslogLocalClientBase -MinSeverity Warning -ClassId SyslogLocalFileLoggingClient -ObjectType SyslogLocalFileLoggingClient

$remoteClient = Initialize-IntersightSyslogRemoteClientBase -Enabled $true -Hostname "11.11.11.11" -MinSeverity Warning `
                -Port 514 -Protocol Udp -ClassId SyslogRemoteLoggingClient -ObjectType SyslogRemoteLoggingClient

$result = New-IntersightSyslogPolicy -Name "sys_log_policy1" -LocalClients @($localClient) -RemoteClients @($remoteClient) -Organization $orgRef