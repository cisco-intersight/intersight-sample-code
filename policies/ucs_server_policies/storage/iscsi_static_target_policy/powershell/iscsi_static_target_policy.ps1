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

$lun = Initialize-IntersightVnicLun -Bootable $true -LunId 100

$result = New-IntersightVnicIscsiStaticTargetPolicy -Name "iscsi_target_policy_1" -Organization $orgRef -IpAddress "172.16.18.11" `
            -Lun $lun -Port 3260 -TargetName "iqn.1992-08.com.netapp:sn.bbe560cbd84911ebad8ad039ea153259:vs.5"