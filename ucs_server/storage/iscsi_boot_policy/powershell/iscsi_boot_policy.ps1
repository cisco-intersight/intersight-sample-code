# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$chap = Initialize-IntersightVnicIscsiAuthProfile -Password "test@11234567" -UserId test

$initiatorStaticIpV4Config = Initialize-IntersightIppoolIpV4Config -Gateway "172.16.2.1" -Netmask "255.255.255.0"

$mutualChap = Initialize-IntersightVnicIscsiAuthProfile -Password "test@1234567" -UserId "admin"

$iscsiAdapterPolicyRef = Get-IntersightVnicIscsiAdapterPolicy -Name "iscsi_adapter_policy_1" | Get-IntersightMoMoRef

$primaryTargetPOlicyRef = Get-INtersightVnicIscsiStaticTargetPolicy -Name "netappprimary" | Get-IntersightMoMoRef

$result =  New-IntersightVnicIscsiBootPolicy -Name "iscsi_boot_policy_1" -Organization $orgRef -InitiatorIpSource Static -TargetSourceType Static `
            -Chap $chap -InitiatorStaticIpV4Address "172.16.2.19" -InitiatorStaticIpV4Config $initiatorStaticIpV4Config `
            -IscsiAdapterPolicy $iscsiAdapterPolicyRef -PrimaryTargetPolicy $primaryTargetPOlicyRef -MutualChap $mutualChap