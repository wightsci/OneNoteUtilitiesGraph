---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONDefaultSection

## SYNOPSIS
Gets the default OneNote Section for new content.

## SYNTAX

```
Get-ONDefaultSection [<CommonParameters>]
```

## DESCRIPTION
Gets the default OneNote Section for new content.

## EXAMPLES

### EXAMPLE 1
```
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
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe to this cmdlet.
## OUTPUTS

### PSCustomObject representing a Graph Section resource.
## NOTES

## RELATED LINKS

[New-ONPage](New-ONPage.md)

[New-ONPageXML](New-ONPageXML.md)

