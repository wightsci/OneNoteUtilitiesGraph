---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONNoteBook

## SYNOPSIS
Gets a OneNote NoteBook.

## SYNTAX

### uri
```
Get-ONNoteBook [-uri <String>] [<CommonParameters>]
```

### id
```
Get-ONNoteBook [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a OneNote NoteBook.
Returns notebook metadata.

## EXAMPLES

### EXAMPLE 1
```
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
```

## PARAMETERS

### -uri
The Uri of the NoteBook to be retreived.

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

### -Id
The Id of the NoteBook to be retreived.

```yaml
Type: String
Parameter Sets: id
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Any object with an 'Id' property.
## OUTPUTS

### PSCustomObject representing a Graph NoteBook resource.
## NOTES

## RELATED LINKS

[Get-ONNoteBooks]()

