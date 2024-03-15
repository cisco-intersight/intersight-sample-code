#here we get the existing default org. One can create new Organization using New-IntersightOrganizationOrganization cmdlets.
$org = Get-IntersightOrganizationOrganization -Name default 
$orgRef = $org | Get-IntersightMoMoRef

$vmediaMapping = Initialize-IntersightVmediaMapping -AuthenticationProtocol None -DeviceType Cdd -FileLocation "nfs://10.193.167.6/exports/vms/ucs-c240m5-huu-3.1.3h.iso"`
                -HostName "12.11.11.13" -MountProtocol Nfs -RemoteFile " ucs-c240m5-huu-3.1.3h.iso" -RemotePath "/exports/vms" -VolumeName v0

$result = New-IntersightVmediaPolicy -Name "vmedia_policy_1" -Enabled $true -Encryption $true -Mappings @($vmediaMapping) -LowPowerUsb $true -Organization $orgRef
