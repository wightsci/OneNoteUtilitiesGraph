---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONSections

## SYNOPSIS
Gets a list of OneNote Sections matching the supplied filter.

## SYNTAX

```
Get-ONSections [[-Filter] <String>]
```

## DESCRIPTION
Gets a list of OneNote Sections matching the supplied filter.
If no filter is supplied then all 
Sections are returned.
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
The filter to be used. OData.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Collection of PSCustomObjects representing Graph Section resources.
## NOTES

## RELATED LINKS

[Get-ONSection]()

