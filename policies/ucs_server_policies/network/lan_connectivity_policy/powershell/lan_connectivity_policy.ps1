# Provide intersight environment details
$config = @{
        BasePath = "https://intersight.com"
        ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
        ApiKeyFilePath = "C:\\secretKey.txt"
        HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
    }
# set intersight configuration, this action needs to be performed once per PowerShell session
Set-IntersightConfiguration @config

# Get an Organization.
$org = Get-IntersightOrganizationOrganization -Name default 

# get the VnicEthIf ref object.
$ethIfRef1 = Get-IntersightVnicEthIf -Name "eth0" 

$ethIfRef2 = Get-IntersightVnicEthIf -Name "eth1" 

$result = New-IntersightVnicLanConnectivityPolicy -Name "lan_connectivity_policy_1" -IqnAllocationType None -PlacementMode Custom -TargetPlatform Standalone `
        -Organization $org -AzureQosEnabled $false -EthIfs @($ethIfRef1,$ethIfRef2)