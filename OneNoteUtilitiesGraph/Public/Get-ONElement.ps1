# Get an element on a page - returned as an XML element
Function Get-ONElement {
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,ParameterSetName='id')]
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,ParameterSetName='data-id')]
        [object]$Page,
        [Parameter(Mandatory=$true,ParameterSetName='id')]
        [string]$Id,
        [Parameter(Mandatory=$true,ParameterSetName='data-id')]
        [string]$DataId
    )
    if ($dataId) { $id = $dataId }
    switch ($Page.GetType().Name) {
        'PSCustomObject' { 
            $page = Get-ONPageXML -page $page 
            break
        }
        'XmlDocument' {
            
        }
    }
    $workElement = $page.SelectSingleNode("/html/body//*[@$($PSCmdlet.ParameterSetName)='$($id)']")
    Return $workElement
}
