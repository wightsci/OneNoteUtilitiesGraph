# Get a list of OneNote Sections
Function Get-ONSections {
    Param(
    [string]$Filter
    )
    Get-ONItems -List -ItemType 'sections' -Filter $filter
}
