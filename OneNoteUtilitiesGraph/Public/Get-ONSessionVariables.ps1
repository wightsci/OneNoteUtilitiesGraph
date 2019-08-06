Function Get-ONSessionVariables {
    [CmdletBinding()]
    Param()
    Write-Host ("OneNote URI      : {0}" -f "$ONuri")
    Write-Host ("Auth Code        : {0}" -f "$authCode")
    Write-Host ("Token Expires at : {0}" -f "$tokenExpires")
    Write-Host ("(Local Time)     : {0}" -f "$(([DateTime]::FromFileTimeUTC($tokenExpires)).ToLocalTime().ToString())")
    Write-Host ("Refresh Token    : {0}" -f "$refresh_token")
    Write-Host ("Access Token     : {0}" -f "$accesstoken")
}
