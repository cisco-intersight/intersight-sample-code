# Set up intersight environment this action is required once per powershell session
$config = @{
        BasePath = "https://intersight.com"
        ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
        ApiKeyFilePath = "C:\\secretKey.txt"
        HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
    }
# set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization MoRef
$orgRef = Get-IntersightOrganizationOrganization -Name "default" | Get-IntersightMoMoRef

# get MoRef of chassis policies 
$imcAccessRef = Get-IntersightAccessPolicy -Name "<Name of the Access policy>" | Get-IntersightMoMoRef
$powerPolicyRef = Get-IntersightPowerPolicy -Name "<Name of the Power POlicy>" | Get-IntersightMoMoRef
$snmpPolicyRef = Get-IntersightSnmpPolicy -Name "<Name of the snmp policy>" | Get-IntersightMoMoRef
$thermalPolicyRef = Get-IntersightThermalPolicy -Name "<Name of the thermal policy>" | Get-IntersightMoMoRef

# create a chassis profile
$chassisProfile = New-IntersightChassisProfile -Name "sample_chassis_profile_1" -Organization $orgRef `
                  -PolicyBucket @($imcAccessRef,$powerPolicyRef,$snmpPolicyRef,$thermalPolicyRef)
