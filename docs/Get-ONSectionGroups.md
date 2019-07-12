---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONSectionGroups

## SYNOPSIS
Gets a list of OneNote Section Groups matching the supplied filter.

## SYNTAX

```
Get-ONSectionGroups [-Filter] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets a list of OneNote Section Groups matching the supplied filter.
If no filter is supplied, all SectionGroups will be returned.
The filter must be  vaild OData.

## EXAMPLES

### Example 1
```
PS C:\> Get-ONSectiongroups -Filter "displayname eq 'Work'"

id                               : 0-816F7725BEF00A5F!731386
self                             : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386
createdDateTime                  : 2019-02-28T10:50:52.52Z
displayName                      : Work
lastModifiedDateTime             : 2019-06-27T10:14:26.947Z
sectionsUrl                      : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386/sections
sectionGroupsUrl                 : https://graph.microsoft.com/v1.0/users/me/onenote/sectionGroups/0-816F7725BEF00A5F!731386/sectionGroups
createdBy                        : @{user=}
lastModifiedBy                   : @{user=}
parentNotebook@odata.context     : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups('0-816F7725BEF00A5F%21731386')/parentNotebook/$entity
parentNotebook                   : @{id=0-816F7725BEF00A5F!1273; displayName=Stuart's Notebook; self=https://graph.microsoft.com/v1.0/users/me/onenote/notebooks/0-816F7725BEF00A5F!1273}
parentSectionGroup@odata.context : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sectionGroups('0-816F7725BEF00A5F%21731386')/parentSectionGroup/$entity
parentSectionGroup               :
```

This command gets the SectionGroup whose name is 'Work'.

## PARAMETERS

### -Filter
The filter to be used.
Must be valid OData

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

### Collection of PSCustomObjects representing Graph SectionGroup Resources.
## NOTES

## RELATED LINKS

[Get-ONSectionGroup]()

[Get-ONSections]()

[Get-ONSection]()

