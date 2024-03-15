# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightVnicIscsiAdapterPolicy -Name "iscsi_adapter_policy_1" -Organization $orgRef -ConnectionTimeOut 255 `
            -DhcpTimeout 300 -LunBusyRetryCount 60 