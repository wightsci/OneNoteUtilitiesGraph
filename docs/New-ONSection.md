---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# New-ONSection

## SYNOPSIS
Creates a new OneNote Section.

## SYNTAX

### ByUri
```
New-ONSection -DisplayName <String> -Uri <String> [<CommonParameters>]
```

### ByID
```
New-ONSection -DisplayName <String> -Id <String> [-SectionGroup] [<CommonParameters>]
```

## DESCRIPTION
Creates a new OneNote Section.

## EXAMPLES

### Example 1
```
PS C:\> New-ONSection -DisplayName 'Monday' -Id 0-816F7725BEF00A5F!731581 -SectionGroup

@odata.context       : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups('0-816F7725BEF00A5F%21731581')/sections/$entity
id                   : 0-816F7725BEF00A5F!731583
self                 : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!731583
createdDateTime      : 2019-06-27T14:06:46.343Z
displayName          : Monday
lastModifiedDateTime : 2019-06-27T14:06:46.507Z
isDefault            : False
pagesUrl             : https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!731583/pages
createdBy            : @{user=}
lastModifiedBy       : @{user=}
```

This command creates a new Section  named 'Monday' in the SectionGroup with the listed ID.

## PARAMETERS

### -DisplayName
The name for the new Section.

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
The ID of the destination container. If this is a SectionGroup, then the SectionGroup switch must also be used.

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

### -SectionGroup
Switch to identify that the ID parameter referrs to a SectionGroup, not a Section.

```yaml
Type: SwitchParameter
Parameter Sets: ByID
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
The URL at which the new Section will be created.

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

### PSCustomObject representing the new Graph Section resource.
## NOTES

## RELATED LINKS
