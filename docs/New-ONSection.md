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
New-ONSection [-DisplayName <String>] [-uri <String>] [<CommonParameters>]
```

### ByID
```
New-ONSection [-DisplayName <String>] [-Id <String>] [-SectionGroup] [<CommonParameters>]
```

## DESCRIPTION
Creates a new OneNote Section.

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -DisplayName
The name for the new Section.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -uri
{{ Fill uri Description }}

```yaml
Type: String
Parameter Sets: ByUri
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
{{ Fill Id Description }}

```yaml
Type: String
Parameter Sets: ByID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SectionGroup
{{ Fill SectionGroup Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe to this cmdlet.
## OUTPUTS

### PSCustomObject representing the new Graph Section resource.
## NOTES

## RELATED LINKS
