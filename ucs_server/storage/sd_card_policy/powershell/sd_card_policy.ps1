# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$virtualDrives = Initialize-INtersightSdcardVirtualDrive -Enable $true

$partitions = Initialize-IntersightSdcardPartition -Type Utility -VirtualDrives $virtualDrives

$result = New-IntersightSdcardPolicy -Name "sd-card-policy-1" -Organization $orgRef -Partitions $partitions