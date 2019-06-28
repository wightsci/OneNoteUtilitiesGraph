---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-Config

## SYNOPSIS
Gets configuration information from a file.

## SYNTAX

```
Get-Config [-Path <String>]
```

## DESCRIPTION
Gets configuration information for this module from a file. 
The results are store in the global $settings variable.

## EXAMPLES

### EXAMPLE 1
```
Get-Config
```

This command loads settings from a file at the default location.

### EXAMPLE 2
```
Get-Config -Path .\OneNoteUtilities.config
```

This command loads settings from a file at the specified location.

## PARAMETERS

### -Path
The path to the file.
Default value:

\`$HOME\.config\OneNoteUtilities.config\`

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: '$HOME\.config\OneNoteUtilities.config'
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Save-Config]()

