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
            -VxlanSettings $vxlanSetting -Organization $orgRef