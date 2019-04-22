$url = "https://raw.githubusercontent.com/steverlabs/MyTemplates/master/SupportingFiles/PopulateADDS/AddADUsersAnswerFile.csv"
$output = "$PSScriptRoot\AddADUsersAnswerFile.csv"

Invoke-WebRequest -Uri $url -OutFile $output

Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name "Corp_Users"
Import-Csv $output  | ForEach-Object {
$forest = Get-ADDomain
$userPrincinpal = $_.samAccountName + "@" + $forest.forest
New-ADUser -Name $_.Name `
 -Path $_.ParentOU `
 -SamAccountName  $_.samAccountName `
 -GivenName $_.GivenName`
 -Surname $_.Surname`
 -UserPrincipalName  $userPrincinpal `
 -AccountPassword (ConvertTo-SecureString "Demo@pass123" -AsPlainText -Force) `
 -ChangePasswordAtLogon $false  `
 -Enabled $true
}
Add-ADGroupMember "Domain Admins" "deanm"