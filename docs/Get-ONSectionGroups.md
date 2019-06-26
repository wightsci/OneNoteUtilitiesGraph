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
Get-ONSectionGroups [[-Filter] <String>]
```

## DESCRIPTION
Gets a list of OneNote Section Groups matching the supplied filter.
If no
filter is supplied, all SectionGroups will be returned.
The filter must be 
vaild OData.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Filter
{{ Fill Filter Description }}

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

### None. You cannot pipe to this cmdlet.
## OUTPUTS

### Collection of PSCustomObjects representing Graph SectionGroup Resources.
## NOTES

## RELATED LINKS

[Get-ONSectionGroup]()

[Get-ONSections]()

[Get-ONSection]()

