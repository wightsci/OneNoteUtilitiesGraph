# Generic call for list of OneNote Items. The same notes apply
# as for the singular Get-ONItem function.
Function Get-ONItems {
    [CmdletBinding()]
    Param(
    [Parameter(ParameterSetName='type')]
    [Parameter(ParameterSetName='uri')]
    [switch]$List,
    [ValidateSet("notebooks","sectiongroups","sections","pages")]
    [Parameter(ParameterSetName='type')]
    [string]$ItemType,
    [Parameter(ParameterSetName='type')]
    [Parameter(ParameterSetName='uri')]
    [string]$Filter,
    [Parameter(ParameterSetName='uri')]
    [String]$uri
    )

    if ($filter) {
        $filter = "&`$filter=$filter"
    }
    
    if ($uri) {
        # $workuri ='{0}?top=20{1}' -f $uri, $filter
        $workuri = '{0}?{1}' -f $uri, $filter
    }
    else {
        $workuri = '{0}{2}?$top=100{1}' -f $ONuri, $filter, $itemtype
    }

    Get-ONTokenStatus

    # Use paging...
    do {
        $onitemlist = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $workuri -Method Get
        if ($onitemlist.'@odata.nextLink') { 
            $workuri = $onitemlist.'@odata.nextLink'
            Write-Verbose "Next: $workuri" 
        }
        if ($list.isPresent) {
            $r += $onitemlist.value
        }
        else { 
            $onitemlist.value | ForEach-Object {

                Get-ONItem -uri $_.contenturl

            }
        }
    } While ($workuri -eq $onitemlist.'@odata.nextLink')
    Return $r
}
