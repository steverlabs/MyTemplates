Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name "Corp_Users"
Import-Csv "C:\Scripts\NewUsers.csv" | ForEach-Object {
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