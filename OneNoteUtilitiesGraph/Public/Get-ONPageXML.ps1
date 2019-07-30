# Gets the XHTML content of a Page
Function Get-ONPageXML {
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [object]$Page,
    [Parameter()]
    [Switch]$AsText
    )
    $workuri = "{0}{1}" -f "$($Page.contenturl)" , '?includeIDS=true'
    Write-Verbose $workuri
    #$html = New-Object System.Xml.XmlDocument
    if ($ASText.IsPresent) {
        $html = (Get-ONItem -uri $workuri).OuterXML
    }
    else {
        $html = (Get-ONItem -uri $workuri)
    }
    Return $html
}