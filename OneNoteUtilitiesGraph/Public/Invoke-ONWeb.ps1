# Invoke the OneNote web app and load a page
Function Invoke-ONWeb {
    [CmdletBinding(DefaultParameterSetName = 'page')]   
    Param(
        [Parameter(Position = 0, ParameterSetName = 'page', Mandatory = $true)]
        [object]$Page,
        [Parameter(Position = 0, ParameterSetName = 'Id', Mandatory = $true)]
        [string]$Id
    )
    If ($Id) {
        $page = Get-ONItem -ItemType 'pages' -Id $id
    }
    Start-Process $page.links.oneNoteWebUrl.href
}
