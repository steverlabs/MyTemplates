# Remove synchronized AD accounts from AzureAD
# USE WITH CARE!
Connect-AzureAD
# Replace sprdemo.org below with your domain name
$dom = '*sprdemo.org*'
$acctList = Get-AzureADUser
foreach ($i in $acctList) {
    $upn = $i.UserPrincipalName
    If ($upn -like $dom) 
        {Write-Host "Deleting " + $i.UserPrincipalName 
        Remove-AzureADUser -ObjectId $i.ObjectId
        }
    }