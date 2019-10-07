[CmdletBinding()]
Param()

# Loader for external modules
$ScriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path
$Public  = @( Get-ChildItem -Path $ScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $ScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
@($Public + $Private)  | Foreach-Object { . $_.FullName }
Export-ModuleMember -Function $Public.Basename

# Get settings from config file
Get-ONConfig
if (!$global:settings.clientid) {
    Write-Host "Would you like me to create a config file?"
    $cid = Read-Host -Prompt "Please provide your Graph client id, or N to exit"
    if ($cid.ToLower() -ne "n") {
        New-ONConfig -ClientID $cid.ToString()
        Get-ONConfig
    }
    else {
        Write-Host "Exiting."
        exit
    }
}

# Settings we don't want hard coded
$clientID = $settings["clientid"]
$scope = $settings["scope"]

#Some Microsoft Graph URIs
#https://graph.microsoft.com/{version}/users/{userPrincipalName}/onenote/
#https://graph.microsoft.com/{version}/users/{id}/onenote/
#https://graph.microsoft.com/{version}/groups/{id}/onenote/
#https://graph.microsoft.com/{version}/sites/{id}/onenote/
#https://graph.microsoft.com/v1.0/me/onenote

$MSGraphRoot='https://graph.microsoft.com/v1.0/me/'
$ONRoot = 'onenote/'
$ONuri = "$MSGraphRoot$ONRoot"

# Microsoft defined redirect endpoint for 'native' apps
$redirectUri = "https://login.microsoftonline.com/common/oauth2/nativeclient"

# Microsoft OAuth URIs
$tokenUri = "https://login.microsoftonline.com/common/oauth2/v2.0/token"
$authorizeUri = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize"

# UrlEncode the ClientID, scope and URLs for special characters 
$clientIDEncoded = [System.Net.WebUtility]::UrlEncode($clientid)
$redirectUriEncoded =  [System.Net.WebUtility]::UrlEncode($redirectUri)
$scopeEncoded = [System.Net.WebUtility]::UrlEncode($scope)

# Build the URL for the authentication request
$authURI = "$($authorizeUri)?response_type=code&redirect_uri=$redirectUriEncoded&client_id=$clientIDEncoded&scope=$scopeEncoded"

# Default OneNote content styles, for reference. These are applied automatically.
$defaultstyles = @{
    'body'  = "font-family:Calibri;font-size:11pt"
    'p'     = "margin-top:0pt;margin-bottom:0pt"
    'h1'    = "font-size:16pt;color:#1e4e79;margin-top:0pt;margin-bottom:0pt"
    'h2'    = "font-size:14pt;color:#2e75b5;margin-top:0pt;margin-bottom:0pt"
    'h3'    = "font-size:12pt;color:#1f3763;margin-top:0pt;margin-bottom:0pt"
    'h4'    = "font-size:12pt;color:#2f5496;font-style:italic;margin-top:0pt;margin-bottom:0pt"
    'h5'    = "color:#2e75b5;margin-top:0pt;margin-bottom:0pt"
    'h6'    = "color:#2e75b5;font-style:italic;margin-top:0pt;margin-bottom:0pt"
    'cite'  = "font-size:9pt;color:#595959;margin-top:0pt;margin-bottom:0pt"
    'quote' = "color:#595959;font-style:italic;margin-top:0pt;margin-bottom:0pt"
    'code'  = "font-family:Consolas;margin-top:0pt;margin-bottom:0pt"
}

# Stores the expiry of the Access Token
#$tokenExpires = $((Get-Date).ToFileTimeUtc())

Function New-ONHTMLItem {

}

# Delete a OneNote NoteBook -- Not available in REST API
Function Remove-ONNoteBook {

}

# Delete a OneNote Section Group -- Not available in REST API
Function Remove-ONSectionGroup {

}

# Delete a OneNote Section -- Not available in REST API
Function Remove-ONSection {
    
}


# Remove a OneNote Page Element
Function Remove-ONElement {

}

# Copy a OneNote Page -- Not Implemented for consumer OneNote
Function Copy-ONPage {
    Param(
        [parameter(ParameterSetName='page')]
        [object]$Page,
        [parameter(ParameterSetName='id')]
        [string]$Id,
        [parameter(ParameterSetName='page')]
        [parameter(ParameterSetName='id')]
        [string]$DestinationId=(Get-ONDefaultSection).Id
    )
    
    if ($page) {
        $id = $page.Id
    } 
    $body =  New-ONJSONItem -hashtable @{ 'id' = "$destinationId" }
    Write-Verbose $body
    $uri = "{0}pages/{1}/copyToSection" -f $ONuri, $Id
    Write-Verbose $uri
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Post -Body $body -ContentType 'application/json'
    <#
    do {
        $operationresponse  =  Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $operatiionuri -Method Get 
    }
    #>
    Write-Verbose "Copy Page"
    Return $response

}

# Copy a OneNote Section -- Not Implemented for consumer OneNote
Function Copy-ONSection {
    Param(
    [string]$DestinationId,
    [string]$Id
    )
    $body =  New-ONJSONItem -hashtable @{ 'id' = "$destinationId" }
    Write-Verbose $body
    $uri = "{0}sections/{1}/copyToSectionGroup" -f $ONuri, $Id
    Write-Verbose $uri
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Post -Body $body -ContentType 'application/json'
    Return $response
}

# Copy a OneNote Section Group -- Not Implemented for consumer OneNote
Function Copy-ONSectionGroup {

}

Get-ONTokenStatus
