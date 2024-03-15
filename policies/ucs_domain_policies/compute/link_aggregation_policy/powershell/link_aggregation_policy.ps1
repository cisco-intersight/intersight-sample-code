# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightFabricLinkAggregationPolicy -Name "LinkAgrregate" -Description "Link Aggregation policy" -LacpRate Fast -SuspendIndividual $true `
                                                    -Organization $orgRef