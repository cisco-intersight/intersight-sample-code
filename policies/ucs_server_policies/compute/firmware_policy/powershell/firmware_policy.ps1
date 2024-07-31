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

# initialize Model bundle version
$modelBundleVersion = Initialize-IntersightFirmwareModelBundleVersion -ModelFamily UCSCC220M7 -BundleVersion "4.3(3.240043)"

# create firmware policy
$result = New-IntersightFirmwarePolicy -Name "firmware_policy_1" -TargetPlatform Standalone -ModelBundleCombo $modelBundleVersion `
          -Organization $org