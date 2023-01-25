## Port Policy
Configures the ports and port roles for the Fabric Interconnect. Each Fabric Interconnect has a set of ports in a fixed port module that you can configure. You can enable or disable a port or a port channel.

The port policy is associated with a switch model. The network configuration limits also vary with the switch model.

The maximum number of ports and port channels supported are:

    Ethernet Uplink, Fibre Channel over Ethernet (FCoE) Uplink port channels, and Appliance port channels (combined)—12

    Ethernet Uplink ports per port channel—16

    FCoE Uplink ports per port channel—16

    Ethernet Uplink and FCoE Uplink ports (combined)—31

    Server ports—54 ports for Cisco UCS 6454 and 108 ports for Cisco UCS 64108 Fabric Interconnects

## Port Policy Properties reference
| SKDs | Properties Description
| ---- | ------------------- |
| [python](https://github.com/CiscoDevNet/intersight-python/) | [Port Policy](https://github.com/CiscoDevNet/intersight-python/tree/main/intersight/model/port_policy.py) properties reference |                 |
| [terraform](https://github.com/CiscoDevNet/terraform-provider-intersight/) | [Port Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/port_policy) properties reference |
| [powershell](https://github.com/CiscoDevNet/intersight-powershell/) | [Port Policy](https://github.com/CiscoDevNet/intersight-powershell/blob/main/docs/New-IntersightPortPolicy.md) properties reference