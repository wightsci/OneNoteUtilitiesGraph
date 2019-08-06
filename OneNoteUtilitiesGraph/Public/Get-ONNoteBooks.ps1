# Get a list of OneNote Notebooks
Function Get-ONNoteBooks {
    [cmdletbinding()]
    Param(
        [parameter(ParameterSetName='filter',Mandatory=$true)]
        [string]$Filter,
        [parameter(ParameterSetName="uri",Mandatory=$false)]
        [string]$Uri="$ONURI/notebooks"
        )
        if ($Filter) {
            Get-ONItems -List -ItemType 'notebooks' -Filter $filter
        }    
        if ($uri) {
            Write-Verbose $uri
            Get-ONItems -List -uri $uri
        }
        
}
