# Gets the XHTML content of a Page
Function Get-ONPageXML {
    Param(
    [Parameter(ParameterSetName='page',Mandatory=$true,ValueFromPipeline=$true)]
    [object]$Page,
    [Parameter(ParameterSetName='id',Mandatory=$true,ValueFromPipeline=$true)]
    [object]$Id,
    [Parameter()]
    [Switch]$AsText
    )
    #$html = New-Object System.Xml.XmlDocument
    switch ($PSCmdlet.ParameterSetName) {
        "page" {
            $workuri = "{0}{1}" -f "$($Page.contenturl)" , '?includeIDS=true'
         }
        "id" {
            $workuri = "{0}{1}" -f (Get-ONPage -id $id).contenturl, '?includeIDS=true'
         }
    }
    $html = (Get-ONItem -uri $workuri)
    if ($ASText.IsPresent) {
        Return $html.OuterXML
    }
    else {
        Return $html
    }
}