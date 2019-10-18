# Gets a list of OneNote Section Groups matching the supplied filter, or a list
Function Get-ONSectionGroups {
    [CmdletBinding()]
    Param(
        [parameter(ParameterSetName = 'filter', Mandatory = $true)]
        [string]$Filter,
        [parameter(ParameterSetName = "uri", Mandatory = $false)]
        [string]$Uri = "$($ONURI)sectiongroups"
    )
    if ($Filter) {
        Get-ONItems -List -ItemType 'sectiongroups' -Filter $filter
    }
    else {
        Write-Verbose $uri
        Get-ONItems -List -uri $uri
    }
}
