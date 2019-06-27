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
Get-Config [[-path] <String>] [<CommonParameters>]
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

### -path
The path to the file.
Default value:

"$HOME\.config\OneNoteUtilities.config"

A typical file would look something like this:

\<?xml version="1.0"?\> \<settings\>     \<setting name="clientid" value="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" /\>     \<setting name="scope" value="https://graph.microsoft.com/Notes.ReadWrite https://graph.microsoft.com/Notes.Create"/\> \</settings\>

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: "$HOME\.config\OneNoteUtilities.config"
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
