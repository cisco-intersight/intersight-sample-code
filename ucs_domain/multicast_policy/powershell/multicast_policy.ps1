# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightFabricMulticastPolicy -Name "fabricMultiCastPolicy" -QuerierState Enabled -SnoopingState Enabled -QuerierIpAddress "11.11.11.11"`
            -Organization $orgRef