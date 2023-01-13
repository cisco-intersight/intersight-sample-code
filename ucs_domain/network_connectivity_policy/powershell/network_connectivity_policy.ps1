# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$result = New-IntersightNetworkconfigPolicy -Name "netwrokConfigPolicy" -Description "test network config policy" -EnableDynamicDns $true `
            -DynamicDnsDomain "xyz.com" -EnableIpv6 $false -AlternateIpv4dnsServer "22.22.22.22" -PreferredIpv4dnsServer "171.70.98.1"`
            -Organization $orgRef 