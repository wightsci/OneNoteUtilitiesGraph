# Get a list of OneNote Notebooks
Function Get-ONNoteBooks {
    [CmdletBinding()]
        Param(
        [string]$Filter
        )
        Get-ONItems -List -ItemType 'noteBooks' -Filter $filter
    }
    