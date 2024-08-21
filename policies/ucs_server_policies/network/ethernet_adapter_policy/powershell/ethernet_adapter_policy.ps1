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

$ArfSettings = Initialize-IntersightVnicArfsSettings -Enabled $true

$CompletionQueSetting = Initialize-IntersightVnicCompletionQueueSettings -Count 5 -RingSize 1

$interruptSetting = Initialize-IntersightVnicEthInterruptSettings -CoalescingTime 125 -CoalescingType MIN -Count 8 -Mode MSIx

$NvgreSetting = Initialize-IntersightVnicNvgreSettings -Enabled $true

$ptpSetting = Initialize-IntersightVnicPtpSettings -Enabled $true

$roceSetting = Initialize-IntersightVnicRoceSettings -ClassOfService NUMBER_5 -Enabled $true -MemoryRegions 131072 -QueuePairs 256 -ResourceGroups 4 -Version NUMBER_1

$rsshSettings = Initialize-IntersightVnicRssHashSettings -Ipv4Hash $true -TcpIpv4Hash $true

$rxQueueSetting = Initialize-IntersightVnicEthRxQueueSettings -Count 4 -RingSize 512

$tcpOffloadSetting = Initialize-IntersightVnicTcpOffloadSettings -LargeReceive $true -LargeSend $true -RxChecksum $true -TxChecksum $true

$txQueueSetting = Initialize-IntersightVnicEthTxQueueSettings -Count 1 -RingSize 256

$vxlanSetting = Initialize-IntersightVnicVxlanSettings -Enabled $true

# create a vnic eth adapter policy
$result = New-IntersightVnicEthAdapterPolicy -Name "vnic_eth_adp_policy_1" -AdvancedFilter $true -ArfsSettings $ArfSettings `
            -CompletionQueueSettings $CompletionQueSetting -InterruptSettings $interruptSetting -NvgreSettings $NvgreSetting `
            -PtpSettings $ptpSetting -RoceSettings $roceSetting -RssHashSettings $rsshSettings -RssSettings $true `
            -RxQueueSettings $rxQueueSetting -TcpOffloadSettings $tcpOffloadSetting -TxQueueSettings $txQueueSetting `
            -VxlanSettings $vxlanSetting -Organization $org