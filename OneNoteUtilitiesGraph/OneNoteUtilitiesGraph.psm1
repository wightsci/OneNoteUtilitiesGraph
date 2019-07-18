[CmdletBinding()]
Param()

# Loader for external modules
$ScriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path
Get-ChildItem $ScriptRoot *.ps1 | Foreach-Object { Import-Module $_.FullName }

Function Get-ONConfig {
    Param(
        [string]$Path="$HOME\.config\OneNoteUtilities.config"
    )
    $Global:settings = @{}
    if (Test-Path $path) {
        $config = [xml](Get-Content $path)
        foreach ($node in $config.settings.setting) {
            $value = $node.Value
            $Global:settings[$node.Name] = $value
        }
    }
    Else {
        Write-Error "No config file found. Please create one."
        Exit
    }
}

Function Save-ONConfig {
[CmdletBinding()]
    Param(
        [string]$path="$HOME\.config\OneNoteUtilities.config",
        [switch]$Force
    )
    $config = [xml]'<?xml version="1.0"?><settings></settings>'
    foreach ($node in $settings.Keys) {
        $setting = $config.CreateElement('setting')
        $setting.SetAttribute('name',$node)
        $setting.SetAttribute('value',$settings[$node])
        $config['settings'].AppendChild($setting) | Out-Null
    }
    if ((Test-Path $path) -and (!$Force.IsPresent)) {
        Throw "Config file exists"
    }
    else {
    $config.Save($path)
    }
}

# Get settings from config file
Get-ONConfig

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

# Get a Graph Authcode, using a web form if required
Function Get-ONAuthCode {
[cmdletbinding()]
Param()
    Add-Type -AssemblyName System.Windows.Forms  
    $form = New-Object -TypeName System.Windows.Forms.Form -Property @{Width=440;Height=640}
    $web  = New-Object -TypeName System.Windows.Forms.WebBrowser -Property @{Width=420;Height=600;Url=$authURI}
    
    $DocComp  = {
        $Global:authURI = $web.Url.AbsoluteUri  
        if ($Global:authURI -match "error=[^&]*|code=[^&]*") {
            Write-Verbose "Closing. URL: $($Global:AuthURI)"
            $form.Close() 
        }
    }

    $web.ScriptErrorsSuppressed = $true
    $web.Add_DocumentCompleted($DocComp)
    $form.Controls.Add($web)
    $form.Add_Shown({$form.Activate()})
    $form.ShowDialog() | Out-Null
    $Global:authQuery = $web.url.Query
    Write-Verbose $web.Url.Query
}

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


# Get a list of OneNote Pages matching the given Filter
Function Get-ONPages {
[cmdletbinding()]
    Param(
        [parameter(ParameterSetName='filter',Mandatory=$true)]
        [string]$Filter,
        [parameter(ParameterSetName="uri",Mandatory=$true)]
        [string]$Uri
        )
        if ($Filter) {
            Get-ONItems -List -ItemType 'pages' -Filter $filter
        }

        if ($uri) {
            Write-Verbose $uri
            Get-ONItems -List -uri $uri
        }
        
}

# Get a OneNote Page - just the metadata
Function Get-ONPage {
    Param(
    [Parameter(ParameterSetName='uri',Mandatory=$true)]
    [string]$Uri,
    [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
    [string]$Id
    )

    if ($uri) {
        Get-ONItem -uri $uri
    }

    if ($Id) {
        Get-ONItem -ItemType 'pages' -Id $Id
    }
    
}

# Get a OneNote Section
Function Get-ONSection {
    Param(
        [Parameter(ParameterSetName='uri',Mandatory=$true)]
        [string]$Uri,
        [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
        [string]$Id
        )

        if ($uri) {
            Get-ONItem -uri $uri
        }

        if ($Id) {
            Get-ONItem -ItemType 'sections' -Id $Id
        }
}

# Get a list of OneNote Sections
Function Get-ONSections {
    Param(
    [string]$Filter
    )
    Get-ONItems -List -ItemType 'sections' -Filter $filter
}

# Get a OneNote Notebook
Function Get-ONNoteBook { 
        Param(
            [Parameter(ParameterSetName='uri',Mandatory=$true)]
            [string]$Uri,
            [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
            [string]$Id
            )
    
            if ($uri) {
                Get-ONItem -uri $uri
            }
    
            if ($Id) {
                Get-ONItem -ItemType 'noteBooks' -Id $Id
            }
}

# Get a list of OneNote Notebooks
Function Get-ONNoteBooks {
[CmdletBinding()]
    Param(
    [string]$Filter
    )
    Get-ONItems -List -ItemType 'noteBooks' -Filter $filter
}

# Generic call for OneNote Item. Creates a URI from an item type and ID
# or uses a URI if provided. Returns metadata objects only if by ID. As a generic call
# this should normally be accessed via one of the object specific wrapper
# functions, such as Get-ONNoteBook
Function Get-ONItem {
    [cmdletbinding()]
    Param(
    [Parameter(ParameterSetName='uri')]
    [string]$uri,
    [Parameter(ParameterSetName='id')]
    [string]$ItemType,
    [Parameter(ParameterSetName='id')]
    [string]$Id
    )

    if ($id) {
        $id = [System.Uri]::EscapeURIString($id)
        Write-Verbose $id
        $uri = '{0}{2}/{1}' -f $ONURI, $Id, $ItemType
        Write-Verbose $uri
    }
    Get-ONTokenStatus
    $endloop  = $false
    [Int]$retrycount = 0
    do {
        try { 
            $workitem = Invoke-RestMethod  -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri #.html.InnerXML
            $endloop = $true
        }
        catch {
            if ($retrycount -gt 3) {
                throw $_
                $endloop = $true
            }
            else {
                Start-Sleep -Seconds 1
                Write-Verbose "Waiting..."
                $Retrycount += 1
            }
        }
        
    } While ($endloop -eq $false)

    return $workitem
    
}

# Generic call for list of OneNote Items. The same notes apply
# as for the singular Get-ONItem function.
Function Get-ONItems {
    [CmdletBinding()]
    Param(
    [Parameter(ParameterSetName='type')]
    [Parameter(ParameterSetName='uri')]
    [switch]$List,
    [ValidateSet("notebooks","sectiongroups","sections","pages")]
    [Parameter(ParameterSetName='type')]
    [string]$ItemType,
    [Parameter(ParameterSetName='type')]
    [Parameter(ParameterSetName='uri')]
    [string]$Filter,
    [Parameter(ParameterSetName='uri')]
    [String]$uri
    )

    if ($filter) {
        $filter = "&`$filter=$filter"
    }
    
    if ($uri) {
        # $workuri ='{0}?top=20{1}' -f $uri, $filter
        $workuri = '{0}?{1}' -f $uri, $filter
    }
    else {
        $workuri = '{0}{2}?$top=100{1}' -f $ONuri, $filter, $itemtype
    }

    Get-ONTokenStatus

    # Use paging...
    do {
        $onitemlist = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $workuri -Method Get
        if ($onitemlist.'@odata.nextLink') { $workuri = $onitemlist.'@odata.nextLink' }
        if ($list.isPresent) {
            $r += $onitemlist.value
        }
        else { 
            $onitemlist.value | ForEach-Object {

                Get-ONItem -uri $_.contenturl

            }
        }
    } While ($workuri -eq $onitemlist.'@odata.nextLink')
    Return $r
}

#Gets a OneNote Section Group
Function Get-ONSectionGroup {    
    Param(
        [Parameter(ParameterSetName='uri',Mandatory=$true)]
        [string]$Uri,
        [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
        [string]$Id
        )

        if ($uri) {
            [xml]$workitem = Get-ONItem -uri $uri
        }

        if ($Id) {
            $workitem = Get-ONItem -ItemType 'sectionGroups' -Id $Id
        }

        Return $workitem
}

# Gets a list of OneNote Section Groups matching the supplied filter
Function Get-ONSectionGroups {
    Param(
        [Parameter(Mandatory=$true)]
    [string]$Filter
    )
    Get-ONItems -List -ItemType 'sectionGroups' -Filter $filter
}

Function Get-ONResource {

}

Function Get-ONResources {

}

# Gets the default OneNote Section for new content creation
Function Get-ONDefaultSection {
Get-ONSections -filter "isDefault eq true"
}

# Get an element on a page - returned as an XML element
Function Get-ONElement {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Id,
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [object]$Page
    )
    $workelement = $page.SelectSingleNode("/html/body//*[@id='$($id)']")
    Return $workelement
}

# Create a new OneNote NoteBook
Function New-ONNoteBook {
    Param (
        [Parameter(Mandatory=$true)]
        [string]$DisplayName
    )
    $uri = "{0}{1}" -f $ONuri, 'notebooks'
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "NoteBook"
    Return $response
}

# Create a new OneNote Section Group
Function New-ONSectionGroup {
    Param(
        [Parameter(ParameterSetName='ByID',Mandatory=$true)]
        [Parameter(ParameterSetName='ByUri',Mandatory=$true)]
        [string]$DisplayName,
        [Parameter(ParameterSetName='ByUri',Mandatory=$true)]
        [string]$Uri,
        [Parameter(ParameterSetName='ByID',Mandatory=$true)]
        [string]$Id
    )
    if ($id) {
        $uri = "{0}notebooks/{1}/sectiongroups" -f $ONuri,  $id
    }
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "SectionGroup"
    Return $response
}

# Create a new OneNote Section
Function New-ONSection {
    Param(
        [Parameter(ParameterSetName='ByID',Mandatory=$true)]
        [Parameter(ParameterSetName='ByUri',Mandatory=$true)]
        [string]$DisplayName,
        [Parameter(ParameterSetName='ByUri',Mandatory=$true)]
        [string]$Uri,
        [Parameter(ParameterSetName='ByID',Mandatory=$true)]
        [string]$Id,
        [Parameter(ParameterSetName="ByID")]
        [switch]$SectionGroup
    )
    if ($id) {
        if ($SectionGroup.IsPresent) {
        $uri = "{0}sectionGroups/{1}/sections" -f $ONuri,  $id
        }
        else {
            $uri = "{0}notebooks/{1}/sections" -f $ONuri,  $id
        }
    }
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "Section"
    Return $response

}

# Create new page in OneNote. Uses the default section if no section URI provided
Function New-ONPage {
    Param(
    [Parameter(ParameterSetName='html')]
    [Parameter(ParameterSetName='page')]    
    [string]$Uri=(Get-ONDefaultSection).pagesUrl,
    [Parameter(ParameterSetName='html',Mandatory=$true)]
    [string]$Html,
    [Parameter(ParameterSetName='page',Mandatory=$true)]
    [object]$Page
    )

    if ($Page) {
        $html = $page.OuterXML
    }

    $body = "{0}{1}" -f '<!DOCTYPE html>', $html
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "text/html"
    Write-Verbose "Page"
    Return $response
}

Function New-ONJSONItem {
    Param(
        $Hashtable
    )
    $workJSOn = $hashtable | ConvertTo-Json
    Return $workJSON
}

Function New-ONHTMLItem {

}

Function New-ONElement {
    Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "head","body","title","meta","h1","h2","h3","h4","h5","h6","p","ul","ol","li","pre","b","i","table","tr","td","div","span","img","br","cite","text"
    )]
    [string]$Type,
    [Parameter(Mandatory=$true)]
    [object]$Document
    )

    if ($Type -eq 'text') {
        $workelement = $Document.CreateTextNode('')
    }
    else {
        $workelement = $Document.CreateElement($Type)
        $workelement.setAttribute("lang","en-GB")
        #$workElement.load(([String]$workelement).replace('"',"'"))
    }
    
    Return $workelement
}

# Creates a new XHTML page with Title and appropriate metadata
Function New-ONPageXML {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Title
    )

<#
Create pages as an XML document to allow the normal DOM type manipulations, then when done, 
coerce the page to a string and add the "<DOCTYPE html>" to the top before passing it to the Graph
#>

    $xmldoc = New-Object System.Xml.XmlDocument
    $xmldoc.InnerXml = '<html />'
    $xmldoc.DocumentElement.SetAttribute("lang","en-GB")
    $tag = New-ONElement -type head -Document $xmldoc
    $head = $xmldoc.DocumentElement.AppendChild($tag)
    $tag = New-ONElement -Type title -Document $xmldoc
    $tag.innertext = $Title
    $title = $head.AppendChild($tag)
    $tag = New-ONElement -type meta -Document $xmldoc
    $tag.setAttribute('http-equiv',"Content-Type")
    $tag.setAttribute('content','text/html; charset=utf-8')
    $meta = $head.AppendChild($tag)
    $tag = New-ONElement -type meta -Document $xmldoc
    $tag.setAttribute('name',"created")
    $tag.setAttribute('content',$((Get-Date).ToString('O')))
    $meta = $head.AppendChild($tag)
    $tag = New-ONElement -Type body -Document $xmldoc
    $body = $xmldoc.DocumentElement.AppendChild($tag)
    Return $xmldoc
}

# Gets the XHTML content of a Page
Function Get-ONPageXML {
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [object]$Page,
    [Parameter()]
    [Switch]$AsText
    )
    $workuri = "{0}{1}" -f "$($Page.contenturl)" , '?includeIDS=true'
    Write-Verbose $workuri
    #$html = New-Object System.Xml.XmlDocument
    if ($ASText.IsPresent) {
        $html = (Get-ONItem -uri $workuri).OuterXML
    }
    else {
        $html = (Get-ONItem -uri $workuri)
    }
    Return $html
}

# Invoke the default OneNote application and load a page
Function Invoke-ONApp {
    [CmdletBinding(DefaultParameterSetName='page')]
    Param(
        [parameter(Position=0,ParameterSetName="page",Mandatory=$true)]
        [object]$Page,
        [parameter(Position=0,ParameterSetName="id",Mandatory=$true)]
        [string]$Id
    )
    If ($Id) {
        $page = Get-ONItem -ItemType 'pages' -Id $id
    }
    Start-Process  $page.links.oneNoteClientUrl.href
}

# Invoke the OneNote web app and load a page
Function Invoke-ONWeb {
    [CmdletBinding(DefaultParameterSetName='page')]   
    Param(
    [Parameter(Position=0,ParameterSetName='page',Mandatory=$true)]
    [object]$Page,
    [Parameter(Position=0,ParameterSetName='Id',Mandatory=$true)]
    [string]$Id
    )
    If ($Id) {
        $page = Get-ONItem -ItemType 'pages' -Id $id
    }
    Start-Process $page.links.oneNoteWebUrl.href
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

# Delete a OneNote Page
Function Remove-ONPage {
    Param (
        [Parameter(Mandatory=$true)]
        [string]$Id
    )
    $uri = "{0}{1}/{2}" -f $ONuri, 'pages', $Id
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method delete
    Write-Verbose "Page"
    Return $response
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

# Get a list of recently accessed OneNote NoteBooks
Function Get-ONRecentNoteBooks {
    $uri = "{0}{1}" -f $ONuri, 'notebooks/getrecentnotebooks(includePersonalNotebooks=true)'
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Get
    Return $response.value
}

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


Function Get-ONSessionVariables {
    [CmdletBinding()]
    Param()
    Write-Host ("OneNote URI      : {0}" -f "$ONuri")
    Write-Host ("Auth Code        : {0}" -f "$authCode")
    Write-Host ("Token Expires at : {0}" -f "$tokenExpires")
    Write-Host ("(Local Time)     : {0}" -f "$(([DateTime]::FromFileTimeUTC($tokenExpires)).ToLocalTime().ToString())")
}

# Some tests of functionality...
Function Test-ONUtilities {
    [CmdletBinding()]
    Param()

Write-Verbose "Test Suite"
Write-Verbose "=========="

Write-Verbose "_-Getting Default Section-_"
$ds = Get-ONDefaultSection
$ds | Select-Object * | Write-Verbose

Write-Verbose "_-Creating a new Page-_"
$np = New-ONPageXML -Title "Test Page $((Get-Date).toString())"
$h1 = New-ONElement -Type h1 -Document $np
$h1.InnerText = 'Hello World'
[void]$np['html']['body'].AppendChild($h1)
$workuri =  $ds.pagesUrl
Write-Verbose "Creating Page at: $workuri"
$response = New-ONPage -URI $workuri -Page $np
Write-Verbose "Sent"

Write-Verbose "_-Trying to get the new Page-_"
Start-Sleep -Seconds 3
Get-ONPage -id $response.Id | ForEach-Object { (Get-ONPageXML -Page $_).OuterXML }

Write-Verbose "_-Trying to get a specific element from a specific Page-_"
$p = Get-ONPageXML -Page (Get-ONPage -id '0-e05582da051f07451e1cd93706e57838!1-816F7725BEF00A5F!1299')
Get-ONElement -page $p -id 'div:{c2203899-70ef-0fcb-135b-bc6bfdfc4e09}{32}'

Write-Verbose "_-Testing Paging-_"
(Get-ONPages -uri "$((Get-ONSections -Filter "displayName eq 'Unfiled Notes'").pagesurl)").Count

}

Get-ONTokenStatus
