# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

#Create fabric control policy

$result = New-IntersightFabricFlowControlPolicy -Name "fabric_flow" -ReceiveDirection Enabled -SendDirection Enabled -PriorityFlowControlMode Auto`
            -Organization $orgRef -Description "fabric flow control"