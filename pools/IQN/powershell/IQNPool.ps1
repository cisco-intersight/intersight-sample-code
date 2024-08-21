# Provide intersight environment details
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration, this action needs to be performed once per PowerShell session
Set-IntersightConfiguration @config

# Get an organization
$org = Get-IntersightOrganizationOrganization -Name default 

$iqnSuffixBlock = Initialize-IntersightIqnpoolIqnSuffixBlock -Suffix "iscsi01" -From 0 -To 9

# create IqnPool
$result = New-IntersightIqnpoolPool -Name IQNPool_1 -Prefix "iqn.2023-06.abc.com" -IqnSuffixBlocks $iqnSuffixBlock `
          -Organization $org