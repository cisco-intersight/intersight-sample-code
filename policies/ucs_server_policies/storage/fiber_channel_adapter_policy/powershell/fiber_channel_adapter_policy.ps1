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

$errorRecoverySetting = Initialize-IntersightVnicFcErrorRecoverySettings -Enabled $true -IoRetryCount 8 `
                        -IoRetryTimeout 5 -LinkDownTimeout 3000 -PortDownTimeout 5000

$flogiSetting = Initialize-IntersightVnicFlogiSettings -Retries 0 -Timeout 4000

$interruptSetting = Initialize-IntersightVnicFcInterruptSettings -Mode INTx

$plogiSettings = Initialize-IntersightVnicPlogiSettings -Retries 8 -Timeout 3000

$rxQueueSettings = Initialize-IntersightVnicFcQueueSettings -RingSize 64 

$scsiQueueSettings = Initialize-IntersightVnicScsiQueueSettings -Count 1 -RingSize 512

$txQueueSettings = Initialize-IntersightVnicFcQueueSettings -RingSize 64

$result = New-IntersightVnicFcAdapterPolicy -Name "fiber-channel-adapter-policy-1" -Organization $org `
            -ErrorDetectionTimeout 2000 -ErrorRecoverySettings $errorRecoverySetting -FlogiSettings $flogiSetting `
            -InterruptSettings $interruptSetting -IoThrottleCount 512 -LunCount 1024 -LunQueueDepth 20 `
            -PlogiSettings $plogiSettings -ResourceAllocationTimeout 10000 -RxQueueSettings $rxQueueSettings `
            -ScsiQueueSettings $scsiQueueSettings -TxQueueSettings $txQueueSettings

