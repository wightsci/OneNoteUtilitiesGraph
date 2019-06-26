---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Save-Config

## SYNOPSIS
Saves the settings object to an XML file.

## SYNTAX

```
Save-Config [[-path] <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
Saves the settings object to an XML file, allowing storage of information not suitable for
embedding in a script or module.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -path
Defines the path to save the settings file to.
Defaults to;

"$HOME\.config\OneNoteUtilities.config"

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

### -Force
Switch parameter to allow overwriting an existing file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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

## OUTPUTS

## NOTES

## RELATED LINKS