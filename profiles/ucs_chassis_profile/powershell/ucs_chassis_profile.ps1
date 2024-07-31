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
$org = Get-IntersightOrganizationOrganization -Name "default" 

# get chassis policies 
$imcAccess = Get-IntersightAccessPolicy -Name "access_policy_1" 
$powerPolicy = Get-IntersightPowerPolicy -Name "power_policy_1" 
$snmpPolicy = Get-IntersightSnmpPolicy -Name "snmp_policy_1" 
$thermalPolicy = Get-IntersightThermalPolicy -Name "thermal_policy_1" 

# create a chassis profile
$chassisProfile = New-IntersightChassisProfile -Name "sample_chassis_profile_1" -Organization $org `
    -PolicyBucket @($imcAccess, $powerPolicy, $snmpPolicy, $thermalPolicy)
