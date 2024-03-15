# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$lun = Initialize-IntersightVnicLun -Bootable $true -LunId 100

$result = New-IntersightVnicIscsiStaticTargetPolicy -Name "iscsi_target_policy_1" -Organization $orgRef -IpAddress "172.16.18.11" `
            -Lun $lun -Port 3260 -TargetName "iqn.1992-08.com.netapp:sn.bbe560cbd84911ebad8ad039ea153259:vs.5"