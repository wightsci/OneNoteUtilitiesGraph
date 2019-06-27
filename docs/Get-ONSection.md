---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONSection

## SYNOPSIS
Gets a OneNote Section.

## SYNTAX

### uri
```
Get-ONSection -uri <String> [<CommonParameters>]
```

### id
```
Get-ONSection -Id <String> [<CommonParameters>]
```

## DESCRIPTION
Gets a OneNote Section.

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -uri
The Uri of the section to be retreived.

```yaml
Type: String
Parameter Sets: uri
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the section to be retrieved.


```yaml
Type: String
Parameter Sets: id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Any object with an 'ID' property
## OUTPUTS

### PSCustomObject representing a Graph Section resource.
## NOTES

## RELATED LINKS
