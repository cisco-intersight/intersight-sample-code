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

$snmpTrap = Initialize-IntersightSnmpTrap -Community "trapCommString" -Destination "11.11.11.11" -Enabled $true `
            -Port 162 -Type Trap -Version V2

$snmpUser = Initialize-IntersightSnmpUser -AuthType MD5 -Name user1 -PrivacyPassword "test@12334" -AuthPassword "test@12345" `
           -PrivacyType AES -SecurityLevel AuthPriv

$result = New-IntersightSnmpPolicy -Name "snmp_policy" -AccessCommunityString accCommString -CommunityAccess Disabled `
         -Enabled $true -EngineId "EngineID" -SnmpPort 161 -Organization $org `
         -SnmpTraps @($snmpTrap) -SnmpUsers @($snmpUser)