# Generic call for OneNote Item. Creates a URI from an item type and ID
# or uses a URI if provided. Returns metadata objects only if by ID. As a generic call
# this should normally be accessed via one of the object specific wrapper
# functions, such as Get-ONNoteBook
Function Get-ONItem {
    [cmdletbinding()]
    Param(
    [Parameter(ParameterSetName='uri')]
    [string]$uri,
    [ValidateSet("notebooks","sectiongroups","sections","pages")]
    [Parameter(ParameterSetName='id')]
    [string]$ItemType,
    [Parameter(ParameterSetName='id')]
    [string]$Id
    )

    if ($id) {
        $id = [System.Uri]::EscapeURIString($id)
        Write-Verbose $id
        $uri = '{0}{2}/{1}' -f $ONURI, $Id, $ItemType
    }
    Write-Verbose "URI: $uri"
    Get-ONTokenStatus
    $endloop  = $false
    [Int]$retrycount = 0
    do {
        try { 
            $workitem = Invoke-RestMethod  -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri #.html.InnerXML
            $endloop = $true
        }
        catch {
            if ($retrycount -gt 3) {
                throw $_
                $endloop = $true
            }
            else {
                Start-Sleep -Seconds 1
                Write-Verbose "Waiting..."
                $Retrycount += 1
            }
        }
        
    } While ($endloop -eq $false)

    return $workitem
    
}
