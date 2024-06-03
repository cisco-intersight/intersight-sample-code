## Device Connector Policy
Lets you choose the Configuration from Intersight only option to control configuration changes allowed from Cisco IMC. The Configuration from Intersight only option is enabled by default. You will observe the following changes when you deploy the Device Connector policy in Intersight:

    Validation tasks will fail:

        If Intersight Read-only mode is enabled in the claimed device.

        If the firmware version of the Cisco UCS Standalone C-Series Servers is lower than 4.0(1).

    If Intersight Read-only mode is enabled, firmware upgrades will be successful only when performed from Intersight. Firmware upgrade performed locally from Cisco IMC will fail.

    IPMI over LAN privileges will be reset to read-only level if Configuration from Intersight only is enabled through the Device Connector policy, or if the same configuration is enabled in the Device Connector in Cisco IMC.
    Attention: The Device Connector Policy will not be imported as part of the Server Profile Import.

## Device Connector Policy Properties reference
| SKDs | Properties Description
| ---- | ------------------- |
| [python](https://github.com/CiscoDevNet/intersight-python/) | [Device Connector Policy](https://github.com/CiscoDevNet/intersight-python/tree/main/intersight/model/deviceconnector_policy.py) properties reference |                 |
| [terraform](https://github.com/CiscoDevNet/terraform-provider-intersight/) | [Device Connector Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/deviceconnector_policy) properties reference |
| [powershell](https://github.com/CiscoDevNet/intersight-powershell/) | [Device Connector Policy](https://github.com/CiscoDevNet/intersight-powershell/blob/main/docs/New-IntersightDeviceconnectorPolicy.md) properties reference


