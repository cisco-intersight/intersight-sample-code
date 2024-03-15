# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$m2VirtualDrive = Initialize-IntersightStorageM2VirtualDriveConfig -Enable $true -ControllerSlot MSTORRAID1

$virtualDrivePolicy = Initialize-IntersightStorageVirtualDrivePolicy -DriveCache Default -ReadPolicy Default -StripSize NUMBER_512 -AccessPolicy Default

$raid0Drive = Initialize-IntersightStorageR0Drive -Enable $true -VirtualDrivePolicy $virtualDrivePolicy

$driveGroupRef = Get-IntersightStorageDriveGroup -Name " R0_Disk_3" | Get-IntersightMoMoRef

$result = New-IntersightStorageStoragePolicy -Name "storage_policy_1" -Organization $orgRef -DefaultDriveMode RAID0 `
            -DriveGroup @($driveGroupRef) -M2VirtualDrive $m2VirtualDrive -Raid0Drive $raid0Drive