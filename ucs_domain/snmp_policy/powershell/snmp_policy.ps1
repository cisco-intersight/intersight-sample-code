# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$snmpTrap = Initialize-IntersightSnmpTrap -Community "trapCommString" -Destination "11.11.11.11" -Enabled $true `
            -Port 162 -Type Trap -Version V2

$snmpUser = Initialize-IntersightSnmpUser -AuthType MD5 -Name user1 -PrivacyPassword "test" -AuthPassword "test" -PrivacyType DES `
        -SecurityLevel AuthPriv

$result = New-IntersightSnmpPolicy -Name "snmp_policy" -AccessCommunityString accCommString -CommunityAccess Disabled -Enabled $true `
            -EngineId "EngineID" -SnmpPort 161 -Organization $orgRef -SnmpTraps @($snmpTrap) -SnmpUsers @($snmpUser)