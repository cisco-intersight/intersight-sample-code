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

$errorRecoverySetting = Initialize-IntersightVnicFcErrorRecoverySettings -Enabled $true -IoRetryCount 8 `
                        -IoRetryTimeout 5 -LinkDownTimeout 3000 -PortDownTimeout 5000

$flogiSetting = Initialize-IntersightVnicFlogiSettings -Retries 0 -Timeout 4000

$interruptSetting = Initialize-IntersightVnicFcInterruptSettings -Mode INTx

$plogiSettings = Initialize-IntersightVnicPlogiSettings -Retries 8 -Timeout 3000

$rxQueueSettings = Initialize-IntersightVnicFcQueueSettings -RingSize 64 

$scsiQueueSettings = Initialize-IntersightVnicScsiQueueSettings -Count 1 -RingSize 512

$txQueueSettings = Initialize-IntersightVnicFcQueueSettings -RingSize 64

$result = New-IntersightVnicFcAdapterPolicy -Name "fiber-channel-adapter-policy-1" -Organization $orgRef `
            -ErrorDetectionTimeout 2000 -ErrorRecoverySettings $errorRecoverySetting -FlogiSettings $flogiSetting `
            -InterruptSettings $interruptSetting -IoThrottleCount 512 -LunCount 1024 -LunQueueDepth 20 `
            -PlogiSettings $plogiSettings -ResourceAllocationTimeout 10000 -RxQueueSettings $rxQueueSettings `
            -ScsiQueueSettings $scsiQueueSettings -TxQueueSettings $txQueueSettings

