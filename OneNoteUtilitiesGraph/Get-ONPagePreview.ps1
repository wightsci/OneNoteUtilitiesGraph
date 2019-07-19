Function Get-ONPagePreview {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
        [string]$Id
    )
    $workuri = "{0}pages/{1}/preview" -f $ONuri, $id
    Write-Verbose $workuri
    Get-ONItem -uri $workuri
}