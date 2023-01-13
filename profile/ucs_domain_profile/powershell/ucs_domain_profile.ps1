# Creating a cluster and siwtch profile without policies, policies can  be attached 

$orgRef = Get-IntersightOrganizationOrganization -Name "<Org Name>" | Get-IntersightMoMoRef

# create cluster switch policy

$clusterSiwtchPolicy = New-IntersightFabricSwitchClusterProfile -Name "cluster_switch_profile_1" -Organization $orgRef

$clusterProfileRef = $clusterSiwtchPolicy | Get-IntersightMoMoRef

$fabric_A = New-IntersightFabricSwitchProfile -Name "Fabric_A_profile" -SwitchClusterProfile $clusterProfileRef

$fabric_B = New-IntersightFabricSwitchProfile -Name "Fabric_B_profile" -SwitchClusterProfile $clusterProfileRef