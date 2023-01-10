#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef
$vmediaBoot = Initialize-IntersightBootVirtualMedia -Enabled $true -Subtype CimcMappedHdd -Name "vMedia"
$usbBoot = Initialize-IntersightBootUsb -Name usb -Subtype UsbFdd -Enabled $true
$uefiBoot = Initialize-IntersightBootUefiShell -Name uefi -Enabled $true
$BootPrecisionPolicy = New-IntersightBootPrecisionPolicy -Name testBootPrecision -BootDevices @($vmediaBoot, $usbBoot, $uefiBoot) -Organization $orgRef 