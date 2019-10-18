# Get a list of OneNote Pages matching the given Filter
Function Get-ONPages {
    [CmdletBinding()]
    Param(
        [parameter(ParameterSetName = 'filter', Mandatory = $true)]
        [string]$Filter,
        [parameter(ParameterSetName = "uri", Mandatory = $false)]
        [string]$Uri = "$($ONURI)pages"
    )
    if ($Filter) {
        Get-ONItems -List -ItemType 'pages' -Filter $filter
    }    
    else {
        Write-Verbose $uri
        Get-ONItems -List -uri $uri
    }
            
}
    