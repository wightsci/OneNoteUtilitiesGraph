---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONSections

## SYNOPSIS
Gets a list of OneNote Sections matching the supplied filter, or at the supplied URL.
If no filter or URL is supplied then all Sections in all NoteBooks will be returned.

## SYNTAX

### filter
```
Get-ONSections [-Filter] <String> [<CommonParameters>]
```

### uri
```
Get-ONSections [-Uri <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a list of OneNote Sections matching the supplied filter.
If no filter is supplied then all  Sections are returned.
The filter must be valid OData syntax.

## EXAMPLES

### EXAMPLE 1
```
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
```

## PARAMETERS

### -Filter
The filter to be used.
OData.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
The URL from which to retieve Sections.

```yaml
Type: String
Parameter Sets: uri
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Collection of PSCustomObjects representing Graph Section resources.
## NOTES

## RELATED LINKS

[Get-ONSection]()

