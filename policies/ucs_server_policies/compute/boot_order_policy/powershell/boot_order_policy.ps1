# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 

# initialize vmedia boot device
$vmediaBoot = Initialize-IntersightBootVirtualMedia -Enabled $true -Subtype CimcMappedHdd -Name "vMedia" -ClassId BootVirtualMedia -ObjectType BootVirtualMedia

# initialize usb boot device
$usbBoot = Initialize-IntersightBootUsb -Name usb -Subtype UsbFdd -Enabled $true -ClassId BootUsb -ObjectType BootUsb

# initialize uefi boot device
$uefiBoot = Initialize-IntersightBootUefiShell -Name uefi -Enabled $true -ClassId BootUefiShell -ObjectType BootUefiShell 

#initialize Pxe boot device
$pxeBoot = Initialize-IntersightBootPxe -ClassId BootPxe -ObjectType BootPxe -Enabled $true -InterfaceName eth0 `
           -IpType IPv4 -Name "primary_1"

# initialize san boot device
$bootLoader = Initialize-IntersightBootBootloader -ClassId BootBootloader -ObjectType BootBootloader -Name "bootLoader"
$sanBoot = Initialize-IntersightBootSan -ClassId BootSan -ObjectType BootSan -Enabled $true -InterfaceName "fc0" `
           -Name "secondary" -Wwpn "50:06:01:62:3E:E0:58:36" -Bootloader $bootLoader

# create a boot precision policy with above created boot devices
$BootPrecisionPolicy = New-IntersightBootPrecisionPolicy -Name "BootPrecision_1" -BootDevices @($vmediaBoot, $usbBoot, $uefiBoot, $pxeBoot,$sanBoot) -Organization $org 