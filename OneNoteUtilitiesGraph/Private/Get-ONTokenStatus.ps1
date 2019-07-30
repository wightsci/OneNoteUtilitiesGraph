Function Get-ONTokenStatus {
    [cmdletbinding()]
    Param()
    Write-Verbose "Token Expires:   $tokenExpires"
    Write-Verbose "Curent DateTime: $((Get-Date).ToFileTimeUtc())"
    Write-Verbose "Current Auth Code: $authCode"
    if (("$((Get-Date).ToFileTimeUtc())" -ge "$tokenExpires") -or !$authcode ) {
        Get-ONAuthCode
        # Extract Access token from the returned URI
        $Global:authQuery -match '\?code=(.*)' | Out-Null
        $Global:authCode = $matches[1]
        Write-Verbose "Received an authCode, $authCode"
        Get-ONAccessToken 
    }
}
