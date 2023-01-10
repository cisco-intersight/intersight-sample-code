# get the Organization Ref.
$orgRef = Get-IntersightOrganizationOrganization -Name default | Get-IntersightMORef

$smtpPolicy = New-IntersightSmtpPolicy -Name "smtp_policy_1" -MinSeverity Critical -Enabled $true -SmtpPort 25 -SmtpServer "22.22.22.22" `
                -SmtpRecipients @("xyz@test.com") -Organization $orgRef