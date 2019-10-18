# Get a OneNote Page - just the metadata
Function Get-ONPage {
    Param(
        [Parameter(ParameterSetName = 'uri', Mandatory = $true)]
        [string]$Uri,
        [Parameter(ParameterSetName = 'id', ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [string]$Id
    )

    if ($uri) {
        Get-ONItem -uri $uri
    }

    if ($Id) {
        Get-ONItem -ItemType 'pages' -Id $Id
    }
    
}
