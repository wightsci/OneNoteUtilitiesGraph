# Set the level of a NoneNote Page
Function Set-ONPageLevel {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Id,
        [Parameter(Mandatory=$true)]
        [ValidateSet(0,1,2)]
        $Level
    )
    $uri = "{0}{1}/{2}" -f $ONuri, 'pages', $Id
    $body = ConvertTo-Json @{ 'level' =  "$Level"}
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Patch -ContentType 'application/json' -body $body
    Return $response
}