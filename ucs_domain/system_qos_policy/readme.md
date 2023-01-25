## System Qos Policy
Implements network traffic prioritization based on the importance of the connected network by assigning system classes for individual vNICs. Intersight uses Data Center Ethernet (DCE) to handle all traffic inside a Cisco UCS domain. This industry standard enhancement to Ethernet divides the bandwidth of the Ethernet pipe into eight virtual lanes. Two virtual lanes are reserved for internal system and management traffic. You can configure quality of service (QoS) for the other six virtual lanes. System classes determine how the DCE bandwidth in these six virtual lanes is allocated across the entire Cisco UCS domain.

Each system class reserves a specific segment of the bandwidth for a specific type of traffic, which provides a level of traffic management, even in an oversubscribed system. For example, you can configure the Fibre Channel Priority system class to determine the percentage of DCE bandwidth allocated to FCoE traffic. The configuration setup validates each input on the system class to prevent duplicate or invalid entries.

This feature is in preview and is not meant for use in your production environment. Cisco recommends that you use this feature on a test network or system.

The following list describes the system classes that you can configure.

- Platinum, Gold, Silver, and Bronze—A configurable set of system classes that you can include in the QoS policy for a service profile. Each system class manages one lane of traffic. All properties of these system classes are available for you to assign custom settings and policies.

- Best Effort—A system class that sets the quality of service for the lane reserved for basic Ethernet traffic. Some properties of this system class are preset and cannot be modified. For example, this class has a drop policy that allows it to drop data packets if required. You cannot disable this system class.

- Fibre Channel—A system class that sets the quality of service for the lane reserved for Fibre Channel over Ethernet traffic. Some properties of this system class are preset and cannot be modified. For example, this class has a no-drop policy that ensures it never drops data packets. You cannot disable this system class.


## System Qos Policy Properties reference
| SKDs | Properties Description
| ---- | ------------------- |
| [python](https://github.com/CiscoDevNet/intersight-python/) | [System Qos Policy](https://github.com/CiscoDevNet/intersight-python/tree/main/intersight/model/fabric_system_qos_policy.py) properties reference |                 |
| [terraform](https://github.com/CiscoDevNet/terraform-provider-intersight/) | [System Qos Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_system_qos_policy) properties reference |
| [powershell](https://github.com/CiscoDevNet/intersight-powershell/) | [System Qos Policy](https://github.com/CiscoDevNet/intersight-powershell/blob/main/docs/New-IntersightFabricSystemQosPolicy.md) properties reference

