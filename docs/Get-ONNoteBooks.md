---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONNoteBooks

## SYNOPSIS
Gets a list of OneNote NoteBooks.
are returned.

## SYNTAX

```
Get-ONNoteBooks [[-Filter] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a list of OneNote NoteBooks matching the supplied filter.
If no filter is supplied then all NoteBooks are returned.

## EXAMPLES

### EXAMPLE 1
```
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
```
## PARAMETERS

### -Filter
An OData filter used to determine which NoteBooks are returned.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe to this cmdlet.
## OUTPUTS

### A collection of PSCustomObjects representing Graph NoteBook resources.
## NOTES

## RELATED LINKS

[Get-ONNoteBook]()

