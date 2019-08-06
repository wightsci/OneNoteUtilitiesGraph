# Get a Graph Access Token
Function Get-ONAccessToken {
    [cmdletbinding()]
    Param()
        if ($refresh_token) {
            $body = "grant_type=refresh_token&redirect_uri=$redirectUriEncoded&client_id=$clientIdEncoded&refresh_token=$refresh_token&scope=$scopeEncoded"
        }
        else {
            $body = "grant_type=authorization_code&redirect_uri=$redirectUriEncoded&client_id=$clientIdEncoded&code=$authCode&scope=$scopeEncoded"            
        }
        Write-Verbose $body
        $Authorization = Invoke-RestMethod -uri $tokenuri -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body -ErrorAction STOP
        Write-Verbose "1: $($Authorization.access_token)"
        Write-Verbose "1: $($Authorization.expires_in)"
        Write-Verbose "1: $($Authorization.refresh_token)"
        $Global:accesstoken = $Authorization.access_token
        $Global:refresh_token = $Authorization.refresh_token
        $Global:tokenExpires = "$((Get-Date).AddSeconds($Authorization.expires_in).ToFileTimeUtc())"
        Write-Verbose "Token Expires at: $((Get-Date).AddSeconds($Authorization.expires_in).ToFileTimeUtc())"
        Write-Verbose "Refresh Token: $refresh_token"
        Write-Host $Authorization
    }
    