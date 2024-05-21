# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

#initialize ldap base properties
$baseProperty = Initialize-IntersightIamLdapBaseProperties -Attribute "CiscoAvPair" -BaseDn "DC=new,DC=com" -BindMethod Anonymous `
                -Domain "new.com" -EnableEncryption $true -EnableGroupAuthorization $true -Filter "sAMAcoountsName" -NestedGroupSearchDepth 120 `
                -Timeout 180

# initialize dns parameter
$dnsParameter = Initialize-IntersightIamLdapDnsParameters -Source Extracted 

# create a ldap policy
$ldapPolicy = New-IntersightIamLdapPolicy -Name "ldap_policy_1" -BaseProperties $baseProperty -DnsParameters $dnsParameter `
          -Enabled $true -Organization $orgRef

$ldapPolicyRef = $ldapPolicy | Get-IntersightMoMoRef

# add provider to ldap policy
$ldapProviderRef = New-IntersightIamLdapProvider -Port 389 -Server "ldap.xyz.com" -LdapPolicy $ldapPolicyRef  | Get-IntersightMoMoRef

# add policy to ldap group
$endPointRoleRef = Get-IntersightIamEndPointRole -Name admin | Get-IntersightMoMoRef
$ldapGroup = New-IntersightIamLdapGroup -Domain "xyz.com" -Name "ldap_group" -LdapPolicy $ldapPolicy -EndPointRole $endPointRoleRef