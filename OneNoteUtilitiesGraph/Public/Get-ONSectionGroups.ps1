# Gets a list of OneNote Section Groups matching the supplied filter
Function Get-ONSectionGroups {
    Param(
        [Parameter(Mandatory=$true)]
    [string]$Filter
    )
    Get-ONItems -List -ItemType 'sectionGroups' -Filter $filter
}
