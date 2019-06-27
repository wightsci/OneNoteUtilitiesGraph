---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# New-ONNoteBook

## SYNOPSIS
Creates a new OneNote NoteBook.

## SYNTAX

```
New-ONNoteBook [-DisplayName] <String> [<CommonParameters>]
```

## DESCRIPTION
Creates a new OneNote NoteBook.

## EXAMPLES

### Example 1
```
PS C:\> New-ONNoteBook -DisplayName 'Class NoteBook'

@odata.context       : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/notebooks/$entity
id                   : 0-816F7725BEF00A5F!731579
self                 : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!731579
createdDateTime      : 2019-06-27T13:47:17.66Z
displayName          : Class NoteBook
lastModifiedDateTime : 2019-06-27T13:47:17.66Z
isDefault            : False
userRole             : Owner
isShared             : False
sectionsUrl          : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!731579/sections
sectionGroupsUrl     : https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!731579/sectionGroups
createdBy            : @{user=}
lastModifiedBy       : @{user=}
links                : @{oneNoteClientUrl=; oneNoteWebUrl=}
```

This command creates a new NoteBook named 'Class NoteBook'

## PARAMETERS

### -DisplayName
The name for the new NoteBook.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### PSCustomObject representing the new Graph NoteBook resource.
## NOTES

## RELATED LINKS
