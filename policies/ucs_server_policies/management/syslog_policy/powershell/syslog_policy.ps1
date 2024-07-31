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

$localClient = Initialize-IntersightSyslogLocalClientBase -MinSeverity Warning -ClassId SyslogLocalFileLoggingClient -ObjectType SyslogLocalFileLoggingClient

$remoteClient = Initialize-IntersightSyslogRemoteClientBase -Enabled $true -Hostname "11.11.11.11" -MinSeverity Warning `
                -Port 514 -Protocol Udp -ClassId SyslogRemoteLoggingClient -ObjectType SyslogRemoteLoggingClient

$result = New-IntersightSyslogPolicy -Name "sys_log_policy1" -LocalClients @($localClient) -RemoteClients @($remoteClient) -Organization $org