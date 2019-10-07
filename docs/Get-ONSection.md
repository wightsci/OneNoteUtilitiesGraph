---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONSection

## SYNOPSIS
Gets a OneNote Section.

## SYNTAX

### uri
```
Get-ONSection -Uri <String> [<CommonParameters>]
```

### id
```
Get-ONSection -Id <String> [<CommonParameters>]
```

## DESCRIPTION
Gets a OneNote Section, based on its ID or URL.

## EXAMPLES

### Example 1
```
PS C:\> Get-ONSection -ID '0-816F7725BEF00A5F!665030'

@odata.context                   : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections/$entity
id                               : 0-816F7725BEF00A5F!665030
self                             : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665030
createdDateTime                  : 2016-10-29T07:43:06.16Z
displayName                      : K-4 Japanese Tree Frog
lastModifiedDateTime             : 2016-10-29T07:43:10.177Z
isDefault                        : False
pagesUrl                         : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665030/pages
createdBy                        : @{user=}
lastModifiedBy                   : @{user=}
parentNotebook@odata.context     : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%21665030')/parentNotebook/$entity
parentNotebook                   : @{id=0-816F7725BEF00A5F!665025; displayName=Real World Samples; self=https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025}
parentSectionGroup@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%21665030')/parentSectionGroup/$entity
parentSectionGroup               :
```

This command retrieves a specific Section based on its ID.

### Example 2
```
PS C:\> Get-ONSection -uri 'https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665030'


@odata.context                   : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections/$entity
id                               : 0-816F7725BEF00A5F!665030
self                             : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665030
createdDateTime                  : 2016-10-29T07:43:06.16Z
displayName                      : K-4 Japanese Tree Frog
lastModifiedDateTime             : 2016-10-29T07:43:10.177Z
isDefault                        : False
pagesUrl                         : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665030/pages
createdBy                        : @{user=}
lastModifiedBy                   : @{user=}
parentNotebook@odata.context     : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%21665030')/parentNotebook/$entity
parentNotebook                   : @{id=0-816F7725BEF00A5F!665025; displayName=Real World Samples; self=https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!665025}
parentSectionGroup@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%21665030')/parentSectionGroup/$entity
parentSectionGroup               :
```

This command retrieves a specific Section based on its URL.

## PARAMETERS

### -Id
The ID of the section to be retrieved.

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

### -Uri
The Url of the section to be retreived.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [Object]
With an 'ID' property
## OUTPUTS

### PSCustomObject
Representing a Graph 'Section' resource.
## NOTES

## RELATED LINKS

[Get-ONSections](Get-ONSections.md)

