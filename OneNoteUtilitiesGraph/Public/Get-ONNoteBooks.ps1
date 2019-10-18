# Get a list of OneNote Notebooks
Function Get-ONNoteBooks {
    Param(
        [parameter(ParameterSetName = 'filter', Mandatory = $False)]
        [string]$Filter
    )
    if ($Filter) {
        Get-ONItems -List -ItemType 'notebooks' -Filter $filter
    }
    else {
        Get-ONItems -List -uri "$($ONURI)notebooks"
    }
}
