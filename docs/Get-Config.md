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
Get-Config [[-path] <String>]
```

## DESCRIPTION
Gets configuration information for this module from a file. 
The results are store in the global $settings variable.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -path
The path to the file.
Default value:

"$HOME\.config\OneNoteUtilities.config"

A typical file would look something like this:

\<?xml version="1.0"?\>
\<settings\>
    \<setting name="clientid" value="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" /\>
    \<setting name="scope" value="https://graph.microsoft.com/Notes.ReadWrite https://graph.microsoft.com/Notes.Create"/\>
\</settings\>

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
