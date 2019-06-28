---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONPage

## SYNOPSIS
Gets a OneNote Page.

## SYNTAX

### uri
```
Get-ONPage -uri <String> [<CommonParameters>]
```

### id
```
Get-ONPage -id <String> [<CommonParameters>]
```

## DESCRIPTION
Gets a OneNote Page.

## EXAMPLES

### EXAMPLE 1
```
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
```

This command gets a specific page by its URL.

### EXAMPLE 2
```
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
parentSection@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/pages('0-bf55e9873b624c5c98d779f0e9f6e6d1%2149-816F7725BEF00A5F%21665031')/parentSection/$entity
parentSection               : @{id=0-816F7725BEF00A5F!665031; displayName=Other Education Examples; self=https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665031}
```

This command gets a specific page by its Id.

## PARAMETERS

### -uri
The Uri of the page to be retreived.

```yaml
Type: String
Parameter Sets: uri
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The Id of the page to be retreived.

```yaml
Type: String
Parameter Sets: id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Any object with an 'ID' property.
## OUTPUTS

### PSCustomObject representing a Graph Page resource.
## NOTES

## RELATED LINKS

[Get-ONPageXML]()

[Get-ONPages]()

