# Set up intersight environment this action is required once per powershell session
$config = @{
        BasePath = "https://intersight.com"
        ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
        ApiKeyFilePath = "C:\\secretKey.txt"
        HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
    }
# Set intersight configuration    
Set-IntersightConfiguration @config

# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

# get the VnicEthIf ref object.
$ethIfRef1 = Get-IntersightVnicEthIf -Name "eth0" | Get-IntersightMoMoRef

$ethIfRef2 = Get-IntersightVnicEthIf -Name "eth1" | Get-IntersightMoMoRef

$result = New-IntersightVnicLanConnectivityPolicy -Name "lan_connectivity_policy_1" -IqnAllocationType None -PlacementMode Custom -TargetPlatform Standalone `
        -Organization $orgRef -AzureQosEnabled $false -EthIfs @($ethIfRef1,$ethIfRef2)