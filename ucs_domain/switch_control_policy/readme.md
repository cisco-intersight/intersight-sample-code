## Switch Control Policy
Enables to configure and manage multiple network operations on the Fabric Interconnects (FI) that include:

- Port Count Optimization—If the VLAN port count optimization is enabled, the Virtual Port (VP) groups are configured on the Fabric Interconnect (FI) and if VLAN port count optimization is disabled, the configured VP groups are removed from the FI.

- MAC Aging Time—Allows to set the MAC aging time for the MAC address table entries. The MAC aging time specifies the time before a MAC entry expires and discards the entry from the MAC address table.

- Link Control Global Settings—Enables configurations of message interval time in seconds and allows to reset the recovery action of an error-disabled port.


## Switch Control Policy Properties reference
| SKDs | Properties Description
| ---- | ------------------- |
| [python](https://github.com/CiscoDevNet/intersight-python/) | [Switch Control Policy](https://github.com/CiscoDevNet/intersight-python/tree/main/intersight/model/fabric_switch_control_policy.py) properties reference |                 |
| [terraform](https://github.com/CiscoDevNet/terraform-provider-intersight/) | [Switch Control Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_switch_control_policy) properties reference |
| [powershell](https://github.com/CiscoDevNet/intersight-powershell/) | [Switch Control Policy](https://github.com/CiscoDevNet/intersight-powershell/blob/main/docs/New-IntersightFabricSwitchControlPolicy.md) properties reference