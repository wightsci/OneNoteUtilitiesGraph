# Get a list of OneNote Sections
Function Get-ONSections {
    [cmdletbinding()]
    Param(
        [parameter(ParameterSetName='filter',Mandatory=$true)]
        [string]$Filter,
        [parameter(ParameterSetName="uri",Mandatory=$false)]
        [string]$Uri="$($ONURI)sections"
        )
        if ($Filter) {
            Get-ONItems -List -ItemType 'sections' -Filter $filter
        }
        else {
            Write-Verbose $uri
            Get-ONItems -List -uri $uri
        }
}
