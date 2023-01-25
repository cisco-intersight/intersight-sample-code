##  SD Card Policy
Configures the Cisco FlexFlash and FlexUtil Secure Digital (SD) cards for the Cisco UCS C-Series Standalone M4 and M5 servers. This policy specifies details of virtual drives on the SD cards. You can configure the SD cards in the Operating System Only, Utility Only, or Operating System + Utility modes.
When two cards are present in the Cisco FlexFlash controller and Operating System is chosen in the SD card policy, the configured OS partition is mirrored. If only single card is available in the Cisco FlexFlash controller, the configured OS partition is non-RAID. The utility partitions are always set as non-RAID.


## SD Card Policy Properties reference
| SKDs | Properties Description
| ---- | ------------------- |
| [python](https://github.com/CiscoDevNet/intersight-python/) | [SD Card Policy](https://github.com/CiscoDevNet/intersight-python/tree/main/intersight/model/sdcard_policy.py) properties reference |                 |
| [terraform](https://github.com/CiscoDevNet/terraform-provider-intersight/) | [SD Card Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/sdcard_policy) properties reference |
| [powershell](https://github.com/CiscoDevNet/intersight-powershell/) | [SD Card Policy](https://github.com/CiscoDevNet/intersight-powershell/blob/main/docs/New-IntersightSdcardPolicy.md) properties reference