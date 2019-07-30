# Get a Graph Access Token
Function Get-ONAccessToken {
    [cmdletbinding()]
    Param()
        $body = "grant_type=authorization_code&redirect_uri=$redirectUriEncoded&client_id=$clientIdEncoded&code=$authCode"
        Write-Verbose $body
        $Authorization = Invoke-RestMethod -uri $tokenuri -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body -ErrorAction STOP
        Write-Verbose "1: $($Authorization.access_token)"
        Write-Verbose "1: $($Authorization.expires_in)"
        $Global:accesstoken = $Authorization.access_token
        $Global:tokenExpires = "$((Get-Date).AddSeconds($Authorization.expires_in).ToFileTimeUtc())"
        Write-Verbose "Token Expires at: $((Get-Date).AddSeconds($Authorization.expires_in).ToFileTimeUtc())"
    }
    