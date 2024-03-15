# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$macAge = Initialize-IntersightFabricMacAgingSettings -MacAgingOption Default -MacAgingTime 14500

$udldSetting = Initialize-IntersightFabricUdldGlobalSettings -MessageInterval 12 -RecoveryAction None

$result = New-IntersightFabricSwitchControlPolicy -Name "switch_control_policy_1" -EthernetSwitchingMode Switch -FcSwitchingMode Switch `
        -MacAgingSettings $macAge -UdldSettings $udldSetting -Organization $orgRef