# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightVnicEthQosPolicy -Name "vnic_eth_qos_policy_1" -Priority BestEffort -Burst 1024 -Mtu 1500 `
            -TrustHostCos $true -Organization $orgRef