[CmdletBinding()]
Param()

Function Get-Config {
<#
.SYNOPSIS

Gets configuration information from a file.

.DESCRIPTION

Gets configuration information for this module from a file. 
The results are store in the global $settings variable.

.PARAMETER Path

The path to the file. Default value:

"$HOME\.config\OneNoteUtilities.config"

A typical file would look something like this:

<?xml version="1.0"?>
<settings>
    <setting name="clientid" value="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" />
    <setting name="scope" value="https://graph.microsoft.com/Notes.ReadWrite https://graph.microsoft.com/Notes.Create"/>
</settings>

#>
    Param(
        [string]$path="$HOME\.config\OneNoteUtilities.config"
    )
    $Global:settings = @{}
    if (Test-Path $path) {
        $config = [xml](Get-Content $path)
        foreach ($node in $config.settings.setting) {
            $value = $node.Value
            $Global:settings[$node.Name] = $value
        }
    }
}

Function Save-Config {
<#
.SYNOPSIS

Saves the settings object to an XML file.

.DESCRIPTION

Saves the settings object to an XML file, allowing storage of information not suitable for
embedding in a script or module.

.PARAMETER Path

Defines the path to save the settings file to. Defaults to;

"$HOME\.config\OneNoteUtilities.config"

.PARAMETER Force

Switch parameter to allow overwriting an existing file.

#>
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
Get-Config

# Settings we don't want hard coded
$clientID = $settings["clientid"]
$scope = $settings["scope"]

#Some Microsoft Graph URIs
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
Function Get-AuthCode {
<#
.SYNOPSIS

Gets an Authorization code from the Microsoft Graph API

.DESCRIPTION

Gets an Authorization code from the Microsoft Graph API. If necessary, displays
a web form for the user to authorize access to OneNote

#>
[cmdletbinding()]
Param()
    Add-Type -AssemblyName System.Windows.Forms
    Write-Verbose $authURI
    
    $form = New-Object -TypeName System.Windows.Forms.Form -Property @{Width=440;Height=640}
    $web  = New-Object -TypeName System.Windows.Forms.WebBrowser -Property @{Width=420;Height=600;Url=$authURI}
    
    $DocComp  = {
        $Global:authURI = $web.Url.AbsoluteUri        
        if ($Global:authURI -match "error=[^&]*|code=[^&]*") {
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
Function Get-AccessToken {
<#
.SYNOPSIS

Gets an Access Token from the Microsoft Graph API

.DESCRIPTION

Gets an Access Token from the Microsoft Graph API.

#>
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

# Get a list of OneNote Pages matching the given Filter
Function Get-ONPages {
<#
.SYNOPSIS

Gets a list of OneNote Pages matching the given Filter, or found at the given URL.

.DESCRIPTION

Gets a list of OneNote Pages matching the given Filter or found at the given URL. The filter
should be valid OData. The information returned is the standard set of Graph metadata for a Page object.

.PARAMETER Filter

The filter to use for the Page list. OData.

.PARAMETER Uri

The location to obtain the pages from.

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

PSCustomObject collection representing Graph Page resources.

.NOTES


.EXAMPLE

Get-ONPages -Filter "startswith(title,'OneNote')" | Select-Object Id,Title

id                                                            title
--                                                            -----
0-1f9aa8a73e9a4f14b4daa7762b5aa530!42-816F7725BEF00A5F!665027 OneNote Class Notebooks
0-634cb14d92da4a1c85ca21fccb057cf7!39-816F7725BEF00A5F!665030 OneNote in Education Resources
0-8d3847e53f7d452aaddc4f63814b8d59!11-816F7725BEF00A5F!1079   OneNote Clipper Installation
0-bf55e9873b624c5c98d779f0e9f6e6d1!21-816F7725BEF00A5F!665031 OneNote and Learning Styles

This command gets a list of pages whose Title starts with 'OneNote'.

.EXAMPLE

Get-ONPages -Uri 'https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665031/pages' | Select-Object Id,Title

id                                                            title
--                                                            -----
0-bf55e9873b624c5c98d779f0e9f6e6d1!44-816F7725BEF00A5F!665031 Other Learning Activities
0-bf55e9873b624c5c98d779f0e9f6e6d1!60-816F7725BEF00A5F!665031 Facilitator Guides
0-bf55e9873b624c5c98d779f0e9f6e6d1!54-816F7725BEF00A5F!665031 Self-Paced Teacher Development
0-bf55e9873b624c5c98d779f0e9f6e6d1!49-816F7725BEF00A5F!665031 Courses Delivered in OneNote
0-bf55e9873b624c5c98d779f0e9f6e6d1!57-816F7725BEF00A5F!665031 New Teacher Orientation
0-bf55e9873b624c5c98d779f0e9f6e6d1!28-816F7725BEF00A5F!665031 Teacher Workbooks
0-bf55e9873b624c5c98d779f0e9f6e6d1!17-816F7725BEF00A5F!665031 Example Lesson Plans
0-bf55e9873b624c5c98d779f0e9f6e6d1!63-816F7725BEF00A5F!665031 How OneNote Enhances Different Learning Styles
0-bf55e9873b624c5c98d779f0e9f6e6d1!21-816F7725BEF00A5F!665031 OneNote and Learning Styles
0-bf55e9873b624c5c98d779f0e9f6e6d1!46-816F7725BEF00A5F!665031 Variety of Education and Learning Examples
0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031 ePortfolio

This command gets a list of Pages found at a specific URL. 

.LINK

Get-ONPage

.LINK

Get-ONPageXML

#>
[cmdletbinding()]
    Param(
        [parameter(ParameterSetName='filter')]
        [string]$Filter,
        [parameter(ParameterSetName="uri")]
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
<#
.SYNOPSIS

Gets a OneNote Page.

.DESCRIPTION

Gets a OneNote Page.

.PARAMETER Uri

The Uri of the page to be retreived.

.PARAMETER Id

The Id of the page to be retreived.

.EXAMPLE

Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031'


@odata.context              : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/pages/$entity
id                          : 0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031
self                        : https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031
createdDateTime             : 2008-05-27T22:37:57Z
title                       : ePortfolio
createdByAppId              :
contentUrl                  : https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031/content
lastModifiedDateTime        : 2014-04-04T22:19:15Z
links                       : @{oneNoteClientUrl=; oneNoteWebUrl=}
parentSection@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/pages('0-bf55e9873b624c5c98d779f0e9f6e6d1%2151-816F7725BEF00A5F%21665031')/parentSection/$entity
parentSection               : @{id=0-816F7725BEF00A5F!665031; displayName=Other Education Examples; self=https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665031}

This command gets a specific page by its URL.

.EXAMPLE

Get-ONPage -id '0-bf55e9873b624c5c98d779f0e9f6e6d1!49-816F7725BEF00A5F!665031'


@odata.context              : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/pages/$entity
id                          : 0-bf55e9873b624c5c98d779f0e9f6e6d1!49-816F7725BEF00A5F!665031
self                        : https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!49-816F7725BEF00A5F!665031
createdDateTime             : 2008-04-14T15:04:35Z
title                       : Courses Delivered in OneNote
createdByAppId              :
contentUrl                  : https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!49-816F7725BEF00A5F!665031/content
lastModifiedDateTime        : 2014-10-24T02:57:51Z
links                       : @{oneNoteClientUrl=; oneNoteWebUrl=}
parentSection@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/pages('0-bf55e9873b624c5c98d779f0e9f6e6d1%2149-816F7725BEF00A5F%21665031')/parentSection
                              /$entity
parentSection               : @{id=0-816F7725BEF00A5F!665031; displayName=Other Education Examples;
                              self=https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665031}

This command gets a specific page by its Id.

.INPUTS

Any object with an 'ID' property.

.OUTPUTS

PSCustomObject representing a Graph Page resource.

.LINK

Get-ONPageXML

.LINK
Get-ONPages

#>    
    Param(
    [Parameter(ParameterSetName='uri')]
    [string]$uri,
    [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true)]
    [string]$id
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
<#
.SYNOPSIS

Gets a OneNote Section.

.DESCRIPTION

Gets a OneNote Section.

.PARAMETER Uri

The Uri of the section to be retreived.

.PARAMETER Id

The Id of the section to be retreived.

.INPUTS

Any object with an 'ID' property


.OUTPUTS

PSCustomObject representing a Graph Section resource.

#>
    Param(
        [Parameter(ParameterSetName='uri')]
        [string]$uri,
        [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true)]
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
<# 
.SYNOPSIS

Gets a list of OneNote Sections matching the supplied filter.

.DESCRIPTION

Gets a list of OneNote Sections matching the supplied filter. If no filter is supplied then all 
Sections are returned. The filter must be valid OData syntax.

.EXAMPLE

Get-ONSections "displayname eq 'Other Education Examples'"


id                               : 0-816F7725BEF00A5F!665031
self                             : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665031
createdDateTime                  : 2016-10-29T07:43:06.21Z
displayName                      : Other Education Examples
lastModifiedDateTime             : 2016-10-29T07:43:09.35Z
isDefault                        : False
pagesUrl                         : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665031/pages
createdBy                        : @{user=}
lastModifiedBy                   : @{user=}
parentNotebook@odata.context     : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%21665031')/parentNotebook/$entity
parentNotebook                   : @{id=0-816F7725BEF00A5F!665025; displayName=Real World Samples;
                                   self=https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025}
parentSectionGroup@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%21665031')/parentSectionGroup/$entity
parentSectionGroup               :

.OUTPUTS

Collection of PSCustomObjects representing Graph Section resources.

.LINK

Get-ONSection

#>
    Param(
    [string]$Filter
    )
    Get-ONItems -List -ItemType 'sections' -Filter $filter
}

# Get a OneNote Notebook
Function Get-ONNoteBook {
<#
.SYNOPSIS

Gets a OneNote NoteBook.

.DESCRIPTION

Gets a OneNote NoteBook. Returns notebook metadata.

.PARAMETER Uri

The Uri of the NoteBook to be retreived.

.PARAMETER Id

The Id of the NoteBook to be retreived.

.EXAMPLE

Get-ONNoteBook -Id 0-816F7725BEF00A5F!665025


@odata.context       : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/notebooks/$entity
id                   : 0-816F7725BEF00A5F!665025
self                 : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025
createdDateTime      : 2016-10-29T07:43:00.693Z
displayName          : Real World Samples
lastModifiedDateTime : 2016-10-29T07:44:42.977Z
isDefault            : False
userRole             : Owner
isShared             : False
sectionsUrl          : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025/sections
sectionGroupsUrl     : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025/sectionGroups
createdBy            : @{user=}
lastModifiedBy       : @{user=}
links                : @{oneNoteClientUrl=; oneNoteWebUrl=}

.INPUTS

Any object with an 'Id' property.

.OUTPUTS

PSCustomObject representing a Graph NoteBook resource.

.LINK

Get-ONNoteBooks

#>    
    Param(
        [Parameter(ParameterSetName='uri')]
        [string]$uri,
        [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true)]
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
<#
.SYNOPSIS

Gets a list of OneNote NoteBooks.
are returned.

.DESCRIPTION

Gets a list of OneNote NoteBooks matching the supplied filter. If no filter is supplied then all NoteBooks
are returned.

.PARAMETER Filter

An OData filter used to determine which NoteBooks are returned.

.EXAMPLE

Get-ONNotebooks "displayname eq 'Real World Samples'"


id                   : 0-816F7725BEF00A5F!665025
self                 : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025
createdDateTime      : 2016-10-29T07:43:00.693Z
displayName          : Real World Samples
lastModifiedDateTime : 2016-10-29T07:44:42.977Z
isDefault            : False
userRole             : Owner
isShared             : False
sectionsUrl          : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025/sections
sectionGroupsUrl     : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025/sectionGroups
createdBy            : @{user=}
lastModifiedBy       : @{user=}
links                : @{oneNoteClientUrl=; oneNoteWebUrl=}

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

A collection of PSCustomObjects representing Graph NoteBook resources.

.LINK

Get-ONNoteBook

#>
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
    Get-TokenStatus
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

    Get-TokenStatus

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
<#
.SYNOPSIS

Gets a OneNote SectionGroup.

.DESCRIPTION

Gets a OneNote SectionGroup using its uRI or Id.

.PARAMETER Uri

The Uri of the SectionGroup to be retreived.

.PARAMETER Id

The Id of the SectionGroup to be retreived.

.EXAMPLE

Get-ONSectionGroup -Id 0-816F7725BEF00A5F!731386

@odata.context                   : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups/$entity
id                               : 0-816F7725BEF00A5F!731386
self                             : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386
createdDateTime                  : 2019-02-28T10:50:52.52Z
displayName                      : Work
lastModifiedDateTime             : 2019-06-19T15:19:45.667Z
sectionsUrl                      : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386/sections
sectionGroupsUrl                 : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386/sectionGroups
createdBy                        : @{user=}
lastModifiedBy                   : @{user=}
parentNotebook@odata.context     : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups('0-816F7725BEF00A5F%21731386')/parentNotebook/$entity
parentNotebook                   : @{id=0-816F7725BEF00A5F!1273; displayName=Stuart's Notebook;
                                   self=https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!1273}
parentSectionGroup@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups('0-816F7725BEF00A5F%21731386')/parentSectionGroup/$entity
parentSectionGroup               :

.INPUTS

Any object with an 'ID' property.

.OUTPUTS

PSCustomObject representing a Graph SectionGroup resource.

.LINK

Get-ONSectionGroups
#>    
    Param(
        [Parameter(ParameterSetName='uri')]
        [string]$uri,
        [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true)]
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
<#
.SYNOPSIS

Gets a list of OneNote Section Groups matching the supplied filter.

.DESCRIPTION

Gets a list of OneNote Section Groups matching the supplied filter. If no
filter is supplied, all SectionGroups will be returned. The filter must be 
vaild OData.

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

Collection of PSCustomObjects representing Graph SectionGroup Resources.

.LINK

Get-ONSectionGroup

.LINK

Get-ONSections

.LINK

Get-ONSection

#>
    Param(
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
<#
.SYNOPSIS

Gets a the default OneNote Section for new content.

.DESCRIPTION

Gets a the default OneNote Section for new content.

.EXAMPLE

Get-ONDefaultSection

id                               : 0-816F7725BEF00A5F!1079
self                             : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!1079
createdDateTime                  : 2013-06-20T16:43:35.257Z
displayName                      : Unfiled Notes
lastModifiedDateTime             : 2019-06-25T17:11:11.467Z
isDefault                        : True
pagesUrl                         : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!1079/pages
createdBy                        : @{user=}
lastModifiedBy                   : @{user=}
parentNotebook@odata.context     : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%211079')/parentNotebook/$entity
parentNotebook                   : @{id=0-816F7725BEF00A5F!1078; displayName=Main NoteBook; self=https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!1078}
parentSectionGroup@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%211079')/parentSectionGroup/$entity
parentSectionGroup               :

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

PSCustomObject representing a Graph Section resource.

.LINK

New-ONPage

.LINK

New-ONPageXML

#>
    Get-ONSections -filter "isDefault eq true"
}

# Get an element on a page - returned as an XML element
Function Get-ONElement {
<#
.SYNOPSIS

Gets an element from a OneNote Page.

.DESCRIPTION

Gets an element from a OneNote Page. Returned as an XML element.

.PARAMETER Page

The page object hosting the element.

.PARAMETER Id

The Id of the page element.

.EXAMPLE

$page = Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML
Get-ONElement -page $page -id 'p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35}'

id                                           style                            #text
--                                           -----                            -----
p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35} margin-top:0pt;margin-bottom:0pt For quizzes and tests, you can track the items that students either get consistently wrong or consistently correct. You can eve...

This command obtains the content of a Page and stores it in the variable $page. Get-ONElement is then used to return a particular paragraph element.

.INPUTS

You can pipe an XHTML Page resource to this cmdlet, such as the output from Get-ONPageXML

.OUTPUTS

An XMLElement object.

.LINK

Get-ONPage

.LINK

Get-ONPageXML

.LINK

Get-ONPages


#>
    Param(
        [string]$id,
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [object]$page
    )
    $workelement = $page.SelectSingleNode("/html/body//*[@id='$($id)']")
    Return $workelement
}

# Create a new OneNote NoteBook
Function New-ONNoteBook {
<#
.SYNOPSIS

Creates a new OneNote NoteBook.

.DESCRIPTION

Creates a new OneNote NoteBook.

.PARAMETER DisplayName

The name for the new NoteBook.

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

PSCustomObject representing the new Graph NoteBook resource.
#>
    Param (
        [string]$DisplayName
    )
    $uri = "{0}{1}" -f $ONuri, 'notebooks'
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-TokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "NoteBook"
    Return $response
}

# Create a new OneNote Section Group
Function New-ONSectionGroup {
<#
.SYNOPSIS

Creates a new OneNote SectionGroup.

.DESCRIPTION

Creates a new OneNote SectionGroup.

.PARAMETER DisplayName

The name for the new SectionGroup.

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

PSCustomObject representing the new Graph SectionGroup resource.
#>
    Param(
        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByUri')]
        [string]$DisplayName,
        [Parameter(ParameterSetName='ByUri')]
        [string]$uri,
        [Parameter(ParameterSetName='ByID')]
        [string]$Id
    )
    if ($id) {
        $uri = "{0}notebooks/{1}/sectiongroups" -f $ONuri,  $id
    }
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-TokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "SectionGroup"
    Return $response
}

# Create a new OneNote Section
Function New-ONSection {
<#
.SYNOPSIS

Creates a new OneNote Section.

.DESCRIPTION

Creates a new OneNote Section.

.PARAMETER DisplayName

The name for the new Section.

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

PSCustomObject representing the new Graph Section resource.
#>
    Param(
        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByUri')]
        [string]$DisplayName,
        [Parameter(ParameterSetName='ByUri')]
        [string]$uri,
        [Parameter(ParameterSetName='ByID')]
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
    Get-TokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "Section"
    Return $response

}

# Create new page in OneNote. Uses the default section if no section URI provided
Function New-ONPage {
<#
.SYNOPSIS

Creates a new OneNote Page.

.DESCRIPTION

Creates a new OneNote Page.

.PARAMETER Uri

The location to create the new Page.

If no location is specified then the default location for new content is used.

.PARAMETER Html

The page content as valid XHTML.

.PARAMETER Page

A Page object.

#>    
    Param(
    [Parameter(ParameterSetName='html')]
    [Parameter(ParameterSetName='page')]    
    [string]$URI=(Get-ONDefaultSection).pagesUrl,
    [Parameter(ParameterSetName='html')]
    [string]$html,
    [Parameter(ParameterSetName='page')]
    [object]$Page
    )

    if ($Page) {
        $html = $page.OuterXML
    }

    $body = "{0}{1}" -f '<!DOCTYPE html>', $html
    Write-Verbose $body
    Get-TokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "text/html"
    Write-Verbose "Page"
    Return $response
}

Function New-ONJSONItem {
    Param(
        $hashtable
    )
    $workJSOn = $hashtable | ConvertTo-Json
    Return $workJSON
}

Function New-ONHTMLItem {

}


Function New-ONElement {
<#
.SYNOPSIS

Creates a new OneNote page element.

.DESCRIPTION

Creates a new OneNote page element.

.PARAMETER Type

The type of element to create. Possible values:

"head","body","title","meta","h1","h2","h3","h4","h5","h6","p","ul","ol","li","pre","b","i","table","tr","td","div","span","img","br","cite"

.PARAMETER Document

The document object in which to create the new element.

#>    
    Param(
    [ValidateSet(
    "head","body","title","meta","h1","h2","h3","h4","h5","h6","p","ul","ol","li","pre","b","i","table","tr","td","div","span","img","br","cite"
    )]
    [string]$Type,
    [object]$Document
    )

    $workelement = $Document.CreateElement($Type)
    Return $workelement
}

# Creates a new XHTML page with Title and appropriate metadata
Function New-ONPageXML {
<#
.SYNOPSIS

Creates the XHTML source for a new OneNote Page.

.DESCRIPTION

Creates the XHTML source for a new OneNote Page.

.PARAMETER Title

The title for the new Page.

#>    
    Param(
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
<#
.SYNOPSIS

Gets the XHTML source of a OneNote Page.

.DESCRIPTION

Gets the XHTML source of a OneNote Page. This cmdlet automatically requests element IDs to aid in page updates.

.PARAMETER Page

A OneNote Page object. Must have a 'contentURL' property.

.EXAMPLE

Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML | Select-Object -Expand OuterXml
<html lang="en-US">
        <head>
                <title>ePortfolio</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        </head>
        <body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">
                <div id="div:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{36}" style="position:absolute;left:48px;top:115px;width:590px">
                        <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{34}" style="margin-top:0pt;margin-bottom:0pt">OneNote makes it easy to <span style="font-weight:bold">track student</span> <span style="font-weight:bold">progress</span> in one notebook. You can easily track items like <span style="font-weight:bold">homework</span>, <span style="font-weight:bold">quizzes</span>, and <span style="font-weight:bold">tests</span> for all your students.  Some teachers create a notebook for each student in the class.  Then they can put homework, quizzes, tests and even a copies of a group project into this ePortfolio. </p>
                        <br />
                        <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35}" style="margin-top:0pt;margin-bottom:0pt">For quizzes and tests, you can track the items that students either get consistently wrong or consistently correct. You can even keep copies of the student's completed quizzes or tests in case you want to refer to them later. </p>
                        <br />
                        <img id="img:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{40}" width="708" height="418" src="https://graph.microsoft.com/v1.0/users('me')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value" data-src-type="image/png" data-fullres-src="https://graph.microsoft.com/v1.0/users('me')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value" data-fullres-src-type="image/png" />
                </div>
        </body>
</html>

This command pipes a Page object to Get-ONPageXML. Expanding the 'html' property displays the full XHTML of the page.

.EXAMPLE

$page = Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML
$page.GetElementsByTagName('p')

id                                           style                            #text
--                                           -----                            -----
p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{34} margin-top:0pt;margin-bottom:0pt {OneNote makes it easy to ,  in one notebook. You can easily track items like , , , , and ...}
p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35} margin-top:0pt;margin-bottom:0pt For quizzes and tests, you can track the items that students either get consistently wrong or consistently correct. You can eve...

This command pipes a Page object to Get-ONPageXML and stores the result in the variable $page. $page can then be accessed as an XMLDocument object.

.INPUTS

Object representing a Page resource. Must have a 'contentURL' property.

.LINK

Get-ONPage

.LINK

Get-ONPages

.LINK

Get-ONElement

#>    
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [object]$Page
    )
    $workuri = "{0}{1}" -f "$($Page.contenturl)" , '?includeIDS=true'
    Write-Verbose $workuri
    #$html = New-Object System.Xml.XmlDocument
    $html = (Get-ONItem -uri $workuri)
    Return $html
}

# Invoke the default OneNote application and load a page
Function Invoke-ONApp {
<#
.SYNOPSIS

Invokes the default OneNote application and loads a page.

.PARAMETER Page

A OneNote Page object.

.PARAMETER Id

The Id of a OneNote Page.

#>
    Param(
        [parameter(ParameterSetName="page")]
        [object]$page,
        [parameter(ParameterSetName="id")]
        [string]$Id
    )
    If ($Id) {
        $page = Get-ONItem -ItemType 'pages' -Id $id
    }
    Start-Process  $page.links.oneNoteClientUrl.href
}

# Invoke the OneNote web app and load a page
Function Invoke-ONWeb {
<#
.SYNOPSIS

Invokes the OneNote web app and loads a page.

.PARAMETER Page

A OneNote Page object.

.PARAMETER Id

The Id of a OneNote Page.

#>    
    Param(
    [Parameter(ParameterSetName='page')]
    [object]$page,
    [Parameter(ParameterSetName='Id')]
    [object]$Id
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
<#
.SYNOPSIS

Deletes a OneNote Page.

.DESCRIPTION

Deletes a OneNote Page.

.PARAMETER Id

The Id of the OneNote Page to delete.

#>
    Param (
        [string]$Id
    )
    $uri = "{0}{1}/{2}" -f $ONuri, 'pages', $Id
    Get-TokenStatus
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
        [object]$page,
        [parameter(ParameterSetName='id')]
        [string]$Id,
        [parameter(ParameterSetName='page')]
        [parameter(ParameterSetName='id')]
        [string]$destinationId=(Get-ONDefaultSection).Id
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
    [string]$destinationId,
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
<#
.SYNOPSIS

Sets the page indentation level of a OneNote Page.

.DESCRIPTION

Sets the page indentation level of a OneNote Page. Not applicable to the first Page in a Section.

.PARAMETER Id

The Id of the OneNotePage.

.PARAMETER Level

The level for the page. Possible values:

0,1,2

#>
    Param(
        [string]$Id,
        [ValidateSet(0,1,2)]
        $Level
    )
    $uri = "{0}{1}/{2}" -f $ONuri, 'pages', $Id
    $body = ConvertTo-Json @{ 'level' =  "$Level"}
    Get-TokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Patch -ContentType 'application/json' -body $body
    Return $response
}

# Get a list of recently accessed OneNote NoteBooks
Function Get-ONRecentNoteBooks {
<#
.SYNOPSIS

Gets the list of most recently accessed OneNote Notebooks.

.DESCRIPTION

Gets the list of most recently accessed OneNote Notebooks.

#>
    $uri = "{0}{1}" -f $ONuri, 'notebooks/getrecentnotebooks(includePersonalNotebooks=true)'
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Get
    Return $response.value
}

Function Update-ONElement {
<#
.SYNOPSIS

Updates a specified element on a OneNote Page.

.DESCRIPTION

Updates a specified element on a OneNote Page.

.PARAMETER Id

The ID of the page to be modified.

.PARAMETER Action

The action to be undertaked. Possible values:

replace, append, delete, insert, or prepend

.PARAMETER Content

The XHTML content for the Action.

.PARAMETER TargetId

The ID of the Page element to be updated, or the 'body' or 'title' keyword.

.PARAMETER Position

The location of the content in relation to the target. Possible values:

after (default) or before

.EXAMPLE

$page = Get-ONPages -Filter "title eq 'Project Zero Work List'" | Get-ONPageXML
$page.OuterXML
<html lang="en-GB">
        <head>
                <title>Project Zero Work List</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <meta name="created" content="2019-06-26T11:35:00.0000000" />
        </head>
        <body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">
                <div id="div:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{29}" style="position:absolute;left:48px;top:115px;width:576px">
                        <p id="p:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{31}" style="margin-top:0pt;margin-bottom:0pt">Implementation needs to be completed by 1st July 2019</p>
                </div>
        </body>
</html>

Update-ONElement -TargetID 'p:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{31}' -Id 0-3f5159c19028036127617e60b3e94771!1-816F7725BEF00A5F!1079 -action replace -content '<p>Implementation needs to be completed by 1st December 2019</p>'
$page = Get-ONPages -Filter "title eq 'Project Zero Work List'" | Get-ONPageXML
$page.OuterXML
<html lang="en-GB">
        <head>
                <title>Project Zero Work List</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <meta name="created" content="2019-06-26T11:35:00.0000000" />
        </head>
        <body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">
                <div id="div:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{29}" style="position:absolute;left:48px;top:115px;width:576px">
                        <p id="p:{e67fb9a8-e119-4610-9812-7249f47331bd}{142}" lang="en-US" style="margin-top:5.5pt;margin-bottom:5.5pt">Implementation needs to be completed by 1st December 2019</p>
                </div>
        </body>
</html>

In this example we first retrieve the XML content of a page using Get-ONPages and Get-ONPageXML, then we update the content of a paragraph element.
We then re-retrieve the page to check that the content has changed. Note that the Id of the paragraph is changed because we are replacing it.

.LINK

Get-ONPageXML

.LINK

Get-ONPages

.LINK

Get-ONPage

#>  
    Param(
        [string]$Id,
        [string]$targetId,
        [Parameter()]
        [ValidateSet('replace','append','delete','prepend')]
        [string]$action,
        [string]$content,
        [Parameter(Mandatory=$false)]
        [ValidateSet('after','before')]
        [string]$position
    )
    Get-TokenStatus
    $uri = "{0}{1}/{2}/content" -f $ONuri, 'pages', $Id
    $body = ConvertTo-Json @(@{ 'target' =  "$targetId"; 'action' = "$action"; 'content' = "--contenthere--"; 'position' = "$position"})
    $body = $body.replace('--contenthere--',$content)
    Write-Verbose $body
    Get-TokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Patch -ContentType 'application/json' -body $body
    Return $response

}

Function Get-TokenStatus {
<#
.SYNOPSIS

Checks for presence of Auth Code and Access Token.

If not present or expired then requests new.

.DESCRIPTION

This function maintains a valid set of Graph credntials, comprising an
Authorization Code and an Access Token.

TYpically this function is called before any access is attempted to the Graph API itself.

#>
    [cmdletbinding()]
    Param()
    Write-Verbose "Token Expires:   $tokenExpires"
    Write-Verbose "Curent DateTime: $((Get-Date).ToFileTimeUtc())"
    Write-Verbose "Current Auth Code: $authCode"
    if (("$((Get-Date).ToFileTimeUtc())" -ge "$tokenExpires") -or !$authcode ) {
        Get-AuthCode
        # Extract Access token from the returned URI
        $authQuery -match '\?code=(.*)' | Out-Null
        $Global:authCode = $matches[1]
        Write-Verbose "Received an authCode, $authCode"
        Get-AccessToken 
    }
}

Function Get-ONPagePreview {
<#
.SYNOPSIS

Gets the Graph-generated preview content for a Page.

.DESCRIPTION

Gets the Graph-generated preview content for a Page, given its ID

.PARAMETER Id

The ID of the Page

.INPUTS

None. You cannot pipe to this cmdlet.

.OUTPUTS

PSCustomObject containing preview text and a link to an image, if available

.EXAMPLE

$page = Get-ONPages -Filter "title eq 'Project Zero Work List'"
Get-ONPagePreview -id $page.id

@odata.context                                                                previewText
--------------                                                                -----------
https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.onenotePagePreview Implementation needs to be completed b...

.LINK

Get-ONPages

.LINK

Get-ONPage

#>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [string]$id
    )
    $workuri = "{0}pages/{1}/preview" -f $ONuri, $id
    Write-Verbose $workuri
    Get-ONItem -uri $workuri
}


Function Get-SessionVariables {
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

Get-TokenStatus
