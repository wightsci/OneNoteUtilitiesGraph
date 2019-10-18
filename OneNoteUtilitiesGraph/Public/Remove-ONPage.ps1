# Delete a OneNote Page
Function Remove-ONPage {
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Id
    )
    $uri = "{0}{1}/{2}" -f $ONuri, 'pages', $Id
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken" } -uri $uri -Method delete
    Write-Verbose "Page"
    Return $response
}
