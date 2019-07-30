# Create new page in OneNote. Uses the default section if no section URI provided
Function New-ONPage {
    Param(
    [Parameter(ParameterSetName='html')]
    [Parameter(ParameterSetName='page')]    
    [string]$Uri=(Get-ONDefaultSection).pagesUrl,
    [Parameter(ParameterSetName='html',Mandatory=$true)]
    [string]$Html,
    [Parameter(ParameterSetName='page',Mandatory=$true)]
    [object]$Page
    )

    if ($Page) {
        $html = $page.OuterXML
    }

    $body = "{0}{1}" -f '<!DOCTYPE html>', $html
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "text/html"
    Write-Verbose "Page"
    Return $response
}
