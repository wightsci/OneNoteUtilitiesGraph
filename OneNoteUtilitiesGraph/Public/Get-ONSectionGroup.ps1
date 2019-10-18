# Get a OneNote Section Group
Function Get-ONSectionGroup {
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
        Get-ONItem -ItemType 'sectiongroups' -Id $Id
    }
}
