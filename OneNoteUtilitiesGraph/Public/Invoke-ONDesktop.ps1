# Invoke the Office 365 OneNote application and load a page
Function Invoke-ONDesktop {
    [CmdletBinding(DefaultParameterSetName = 'page')]
    Param(
        [parameter(Position = 0, ParameterSetName = "page", Mandatory = $true)]
        [object]$Page,
        [parameter(Position = 0, ParameterSetName = "id", Mandatory = $true)]
        [string]$Id
    )
    If ($Id) {
        $page = Get-ONItem -ItemType 'pages' -Id $id
    }
    # Location of the OneNote executable can be found at:
    # HKEY_LOCAL_MACHINE\SOFTWARE\Classes\OneNote\shell\Open\command
    $ONShellCommand = (Get-ItemProperty -Path HKLM:\SOFTWARE\Classes\OneNote\shell\Open\command).'(default)'
    #Clean up the registry entry so that we can reuse it
    $ONShellCommand = ($ONShellCommand -split "/hyperlink" -replace '"')[0]
    Start-Process  $ONShellCommand -ArgumentList '/hyperlink', $page.links.oneNoteClientUrl.href
}