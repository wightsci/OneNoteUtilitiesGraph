# Some tests of functionality...
Function Test-ONUtilities {
    [CmdletBinding()]
    Param()

Write-Verbose "Test Suite"
Write-Verbose "=========="

Write-Verbose "_-Getting Default Section-_"
$ds = Get-ONDefaultSection
$ds | Select-Object * | Write-Verbose

Write-Verbose "_-Creating a new Page-_"
$np = New-ONPageXML -Title "Test Page $((Get-Date).toString())"
$h1 = New-ONElement -Type h1 -Document $np
$h1.InnerText = 'Hello World'
[void]$np['html']['body'].AppendChild($h1)
$workuri =  $ds.pagesUrl
Write-Verbose "Creating Page at: $workuri"
$response = New-ONPage -URI $workuri -Page $np
Write-Verbose "Sent"

Write-Verbose "_-Trying to get the new Page-_"
Start-Sleep -Seconds 3
Get-ONPage -id $response.Id | ForEach-Object { (Get-ONPageXML -Page $_).OuterXML }

Write-Verbose "_-Trying to get a specific element from a specific Page-_"
$p = Get-ONPageXML -Page (Get-ONPage -id '0-e05582da051f07451e1cd93706e57838!1-816F7725BEF00A5F!1299')
Get-ONElement -page $p -id 'div:{c2203899-70ef-0fcb-135b-bc6bfdfc4e09}{32}'

Write-Verbose "_-Testing Paging-_"
(Get-ONPages -uri "$((Get-ONSections -Filter "displayName eq 'Unfiled Notes'").pagesurl)").Count

}
