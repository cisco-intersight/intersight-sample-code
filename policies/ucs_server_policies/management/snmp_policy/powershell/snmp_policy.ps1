# Set up intersight environment this action is required once per powershell session
$config = @{
        BasePath = "https://intersight.com"
        ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
        ApiKeyFilePath = "C:\\secretKey.txt"
        HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
    }
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization.
$org = Get-IntersightOrganizationOrganization -Name default 

# initialize SNMP trap
$snmpTrap = Initialize-IntersightSnmpTrap -Community "trapCommString" -Destination "11.11.11.11" -Enabled $true `
            -Port 162 -Type Trap -Version V2

# initialize SNMP user
$snmpUser = Initialize-IntersightSnmpUser -AuthType MD5 -Name user1 -PrivacyPassword "test@1234" -AuthPassword "test@1234" -PrivacyType AES `
        -SecurityLevel AuthPriv

# create a SNMP policy
$result = New-IntersightSnmpPolicy -Name "snmp_policy_1" -AccessCommunityString accCommString -CommunityAccess Disabled `
         -Enabled $true -EngineId "EngineID" -SnmpPort 161 -SysContact "xyz@test.com" -SysLocation "NYK" -Organization $org `
         -SnmpTraps @($snmpTrap) -SnmpUsers @($snmpUser)