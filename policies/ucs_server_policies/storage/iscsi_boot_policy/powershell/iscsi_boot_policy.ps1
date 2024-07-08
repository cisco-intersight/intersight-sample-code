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

$chap = Initialize-IntersightVnicIscsiAuthProfile -Password "test@11234567" -UserId test

$initiatorStaticIpV4Config = Initialize-IntersightIppoolIpV4Config -Gateway "172.16.2.1" -Netmask "255.255.255.0"

$mutualChap = Initialize-IntersightVnicIscsiAuthProfile -Password "test@1234567" -UserId "admin"

# create a vnic iscsi adapter policy
$iscsiAdapterPolicyRef = New-IntersightVnicIscsiAdapterPolicy -Name "iscsi_adapter_policy_1" -DhcpTimeout 300 -LunBusyRetryCount 25 `
                         -ConnectionTimeOut 150 -Organization $org 

#initialize vnic lun
$lunSetting = Initialize-IntersightVnicLun -Bootable $true -LunId 0

# create primary target policy and get the ref of it
$primaryTargetPOlicy = New-IntersightVnicIscsiStaticTargetPolicy -Name "primary_target_1" -IpAddress "10.193.250.251" `
                          -Port 3232 -TargetName "iqn.2020-12.com.abc:001"  -Organization $org

$result =  New-IntersightVnicIscsiBootPolicy -Name "iscsi_boot_policy_1" -Organization $org -InitiatorIpSource Static -TargetSourceType Static `
            -Chap $chap -InitiatorStaticIpV4Address "172.16.2.19" -InitiatorStaticIpV4Config $initiatorStaticIpV4Config `
            -IscsiAdapterPolicy $iscsiAdapterPolicyRef -PrimaryTargetPolicy $primaryTargetPolicy -MutualChap $mutualChap