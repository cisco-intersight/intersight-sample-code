
# Creating a cluster and siwtch profile without policies, policies can  be attached 
$orgRef = Get-IntersightOrganizationOrganization -Name "<Org Name>" | Get-IntersightMoMoRef

# create a ServerProfile template.
$result = New-IntersightServerProfileTemplate -Name "Test_serverProfile" -Organization $orgRef
