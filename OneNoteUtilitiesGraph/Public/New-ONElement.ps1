Function New-ONElement {
    Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "head","body","title","meta","h1","h2","h3","h4","h5","h6","p","ul","ol","li","pre","b","i","table","tr","td","div","span","img","br","cite","text"
    )]
    [string]$Type,
    [Parameter()]
    [object]$Document=(New-Object -TypeName System.Xml.XmlDocument)
    )
    if ($Type -eq 'text') {
        $workelement = $Document.CreateTextNode('')
    }
    else {
        $workelement = $Document.CreateElement($Type)
        $workelement.setAttribute("lang","en-GB")
        #$workElement.load(([String]$workelement).replace('"',"'"))
    }
    
    Return $workelement
}
