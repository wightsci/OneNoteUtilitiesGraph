# Get an element on a page - returned as an XML element
Function Get-ONElement {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Id,
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [object]$Page
    )
    $workelement = $page.SelectSingleNode("/html/body//*[@id='$($id)']")
    Return $workelement
}
