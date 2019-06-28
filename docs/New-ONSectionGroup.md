---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# New-ONSectionGroup

## SYNOPSIS
Creates a new OneNote SectionGroup.

## SYNTAX

### ByUri
```
New-ONSectionGroup -DisplayName <String> -Uri <String> [<CommonParameters>]
```

### ByID
```
New-ONSectionGroup -DisplayName <String> -Id <String> [<CommonParameters>]
```

## DESCRIPTION
Creates a new OneNote SectionGroup.

## EXAMPLES

### Example 1
```
PS C:\> New-ONSectionGroup -DisplayName 'Week 1' -Id '0-816F7725BEF00A5F!731579'

@odata.context       : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/notebooks('0-816F7725BEF00A5F%21731579')/sectionGroups/$entity
id                   : 0-816F7725BEF00A5F!731581
self                 : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731581
createdDateTime      : 2019-06-27T13:59:25.327Z
displayName          : Week 1
lastModifiedDateTime : 2019-06-27T13:59:25.327Z
sectionsUrl          : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731581/sections
sectionGroupsUrl     : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731581/sectionGroups
createdBy            : @{user=}
lastModifiedBy       : @{user=}
```

This command creates a new SectionGroup in the NoteBook identified by the given ID.

## PARAMETERS

### -DisplayName
The name for the new SectionGroup.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the container in which the SectionGroup will be created.

```yaml
Type: String
Parameter Sets: ByID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
The URL at which the new SectionGroup will be created.

```yaml
Type: String
Parameter Sets: ByUri
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

### None. You cannot pipe to this cmdlet.
## OUTPUTS

### PSCustomObject representing the new Graph SectionGroup resource.
## NOTES

## RELATED LINKS
