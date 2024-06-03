##  IMC Access Policy
Enables you to configure and manage your network through mapping of IP pools to the server profile. This policy allows you to configure a VLAN and associate it with an IP address through the IP pool address.
In-Band IP addresses, Out-Of-Band IP addresses, or both can be configured using the IMC Access Policy. vKVM, IPMI, SOL, and vMedia using vKVM client can be used with either In-Band or Out-Of-Band IP addresses. SNMP, vMedia, and Syslog are currently supported only with In-band IP address and not with Out-Of-Band IP address.

## IMC Access Policy Properties reference
| SKDs | Properties Description
| ---- | ------------------- |
| [python](https://github.com/CiscoDevNet/intersight-python/) | [IMC Access Policy](https://github.com/CiscoDevNet/intersight-python/tree/main/intersight/model/access_policy.py) properties reference |                 |
| [terraform](https://github.com/CiscoDevNet/terraform-provider-intersight/) | [IMC Access Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/access_policy) properties reference |
| [powershell](https://github.com/CiscoDevNet/intersight-powershell/) | [IMC Access Policy](https://github.com/CiscoDevNet/intersight-powershell/blob/main/docs/New-IntersightAccessPolicy.md) properties reference