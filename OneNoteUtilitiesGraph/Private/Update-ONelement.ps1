
Function Update-ONElement {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Id,
        [Parameter(Mandatory=$true)]
        [string]$TargetId,
        [Parameter(Mandatory=$true)]
        [ValidateSet('replace','append','delete','prepend')]
        [string]$Action,
        [Parameter(Mandatory=$true)]
        [string]$Content,
        [Parameter(Mandatory=$false)]
        [ValidateSet('after','before')]
        [string]$Position='before'
    )
    Get-ONTokenStatus
    $uri = "{0}{1}/{2}/content" -f $ONuri, 'pages', $Id
    $body = ConvertTo-Json @(@{ 'target' =  "$targetId"; 'action' = "$action"; 'content' = "$content"; 'position' = "$position"})
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Patch -ContentType 'application/json' -body $body
    Return $response

}
