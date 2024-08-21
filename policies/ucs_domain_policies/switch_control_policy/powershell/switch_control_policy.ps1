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

$macAge = Initialize-IntersightFabricMacAgingSettings -MacAgingOption Default -MacAgingTime 14500

$udldSetting = Initialize-IntersightFabricUdldGlobalSettings -MessageInterval 12 -RecoveryAction None

$result = New-IntersightFabricSwitchControlPolicy -Name "switch_control_policy_1" -EthernetSwitchingMode Switch -FcSwitchingMode Switch `
        -MacAgingSettings $macAge -UdldSettings $udldSetting -Organization $org