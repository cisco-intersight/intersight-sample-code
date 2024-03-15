# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$Result = New-IntersightVnicFcQosPolicy -Name "fc_qos_policy_1" -Organization $orgRef -Burst 1024 -Cos 3 -MaxDataFieldSize 2112