# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$baseProperty = Initialize-IntersightIamLdapBaseProperties -Attribute "CiscoAvPair" -BaseDn "DC=new,DC=com" -BindMethod Anonymous `
                -Domain "new.com" -EnableEncryption $true -EnableGroupAuthorization $true -Filter "sAMAcoountsName" -NestedGroupSearchDepth 120 `
                -Timeout 180

$dnsParameter = Initialize-IntersightIamLdapDnsParameters -Source Extracted 

$result = New-IntersightIamLdapPolicy -Name "ldap_policy_1" -BaseProperties $baseProperty -DnsParameters $dnsParameter -Enabled $true -Organization $orgRef