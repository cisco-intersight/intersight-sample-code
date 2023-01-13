# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

# Initialize the fabric udld setting
$fabricUdldSetting = Initialize-IntersightFabricUdldSettings -AdminState Enabled -Mode Normal

$result = New-IntersightFabricLinkControlPolicy -Name "fabric_link_policy" -Description "fabric link control" -UdldSettings $fabricUdldSetting`
                            -Organization $orgRef