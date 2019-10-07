---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONConfig

## SYNOPSIS
Gets configuration information from a file.

## SYNTAX

```
Get-ONConfig [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets configuration information for this module from a file. 
The results are stored in the global $settings variable.

## EXAMPLES

### EXAMPLE 1
```
Get-ONConfig
```

This command loads settings from a file at the default location.

### EXAMPLE 2
```
Get-ONConfig -Path .\OneNoteUtilities.config
```

This command loads settings from a file at the specified location.

## PARAMETERS

### -Path
The path to the file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: $HOME\.config\OneNoteUtilities.config
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Save-ONConfig](Save-ONConfig.md)

