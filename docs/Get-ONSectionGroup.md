---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONSectionGroup

## SYNOPSIS
Gets a OneNote SectionGroup.

## SYNTAX

### uri
```
Get-ONSectionGroup [-uri <String>] [<CommonParameters>]
```

### id
```
Get-ONSectionGroup [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a OneNote SectionGroup using its URI or ID.

## EXAMPLES

### EXAMPLE 1
```
Get-ONSectionGroup -Id 0-816F7725BEF00A5F!731386

@odata.context                   : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups/$entity
id                               : 0-816F7725BEF00A5F!731386
self                             : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386
createdDateTime                  : 2019-02-28T10:50:52.52Z
displayName                      : Work
lastModifiedDateTime             : 2019-06-19T15:19:45.667Z
sectionsUrl                      : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386/sections
sectionGroupsUrl                 : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386/sectionGroups
createdBy                        : @{user=}
lastModifiedBy                   : @{user=}
parentNotebook@odata.context     : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups('0-816F7725BEF00A5F%21731386')/parentNotebook/$entity
parentNotebook                   : @{id=0-816F7725BEF00A5F!1273; displayName=Stuart's Notebook;
                                   self=https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!1273}
parentSectionGroup@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups('0-816F7725BEF00A5F%21731386')/parentSectionGroup/$entity
parentSectionGroup               :
```

## PARAMETERS

### -uri
The Uri of the SectionGroup to be retreived.

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
The Id of the SectionGroup to be retreived.

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

### Any object with an 'ID' property.
## OUTPUTS

### PSCustomObject representing a Graph SectionGroup resource.
## NOTES

## RELATED LINKS

[Get-ONSectionGroups]()

