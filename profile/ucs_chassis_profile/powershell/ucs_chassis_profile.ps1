# get the Organization ref, If otganization does not exist use the cmdlet New-IntersightOrganizationOrganization to create it.
$orgRef = Get-IntersightOrganizationOrganization -Name "default" | Get-IntersightMoMoRef

$imcAccessRef = Get-IntersightAccessPolicy -Name "<Name of the Access policy>" | Get-IntersightMoMoRef

$powerPolicyRef = Get-IntersightPowerPolicy -Name "<Name of the Power POlicy>" | Get-IntersightMoMoRef

$snmpPolicyRef = Get-IntersightSnmpPolicy -Name "<Name of the snmp policy>" | Get-IntersightMoMoRef

$thermalPolicyRef = Get-IntersightThermalPolicy -Name "<Name of the thermal policy>" | Get-IntersightMoMoRef

New-IntersightChassisProfile -Name "sample_chassis_profile_1" -Organization $orgRef -PolicyBucket @($imcAccessRef,$powerPolicyRef,$snmpPolicyRef,$thermalPolicyRef) `
        -Type Instance -TargetPlatform FIAttached