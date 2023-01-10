# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$localClient = Initialize-IntersightSyslogLocalClientBase -MinSeverity Warning

$remoteClient = Initialize-IntersightSyslogRemoteClientBase -Enabled $true -Hostname "11.11.11.11" -MinSeverity Warning `
                -Port 514 -Protocol Udp

$result = New-IntersightSyslogPolicy -Name "sys_log_policy1" -LocalClients @($localClient) -RemoteClients @($remoteClient) -Organization $orgRef