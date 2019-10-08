---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONTableAsObject

## SYNOPSIS
Converts a Table from a OneNote Page into a PSCustomObject array 

## SYNTAX

```
Get-ONTableAsObject [[-Table] <Object>] [-NoHeaders] [<CommonParameters>]
```

## DESCRIPTION
Converts a Table from a OneNote Page into a PSCustomObject array. This would then be suitable for export to another format.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -NoHeaders
Identifies that the tble does not contain a first row of column headings. The columns will be
named Column 1 .. Column n as required.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Table
An XML representation of a table as returned by **Get-ONElement**.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
Representation of the table as a PSCustomObject array.
## NOTES

## RELATED LINKS
[Get-ONElement](Get-ONElement.md)