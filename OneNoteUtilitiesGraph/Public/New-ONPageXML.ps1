# Creates a new XHTML page with Title and appropriate metadata
Function New-ONPageXML {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Title
    )

<#
Create pages as an XML document to allow the normal DOM type manipulations, then when done, 
coerce the page to a string and add the "<DOCTYPE html>" to the top before passing it to the Graph
#>

    $xmldoc = New-Object System.Xml.XmlDocument
    $xmldoc.InnerXml = '<html />'
    $xmldoc.DocumentElement.SetAttribute("lang", "en-GB")
    $tag = New-ONElement -type head -Document $xmldoc
    $head = $xmldoc.DocumentElement.AppendChild($tag)
    $tag = New-ONElement -Type title -Document $xmldoc
    $tag.innertext = $Title
    $title = $head.AppendChild($tag)
    $tag = New-ONElement -type meta -Document $xmldoc
    $tag.setAttribute('http-equiv', "Content-Type")
    $tag.setAttribute('content', 'text/html; charset=utf-8')
    $meta = $head.AppendChild($tag)
    $tag = New-ONElement -type meta -Document $xmldoc
    $tag.setAttribute('name', "created")
    $tag.setAttribute('content', $((Get-Date).ToString('O')))
    $meta = $head.AppendChild($tag)
    $tag = New-ONElement -Type body -Document $xmldoc
    $body = $xmldoc.DocumentElement.AppendChild($tag)
    Return $xmldoc
}
