# Set up intersight environment this action is required once per powershell session
$config = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}
# set intersight configuration    
Set-IntersightConfiguration @config

# get organization MoRef
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMoMoRef

$iqnSuffixBlock = Initialize-IntersightIqnpoolIqnSuffixBlock -Suffix "iscsi01" -From 0 -To 9

# create IqnPool
$result = New-IntersightIqnpoolPool -Name IQNPool_1 -Prefix "iqn.2023-06.abc.com" -IqnSuffixBlocks $iqnSuffixBlock `
          -Organization $orgRef