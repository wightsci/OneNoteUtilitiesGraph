---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# New-ONPageXML

## SYNOPSIS
Creates the XHTML source for a new OneNote Page.

## SYNTAX

```
New-ONPageXML [-Title] <String> [<CommonParameters>]
```

## DESCRIPTION
Creates the XHTML source for a new OneNote Page.

## EXAMPLES

### Example 1
```
PS C:\> New-ONPageXML -Title 'Timetable'

html
----
html
```

This command outputs an XHTML object for an empty page with the title 'Timetable'

## PARAMETERS

### -Title
The title for the new Page.

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

## OUTPUTS

### XMLDocument
Object representing the new page.

## NOTES

## RELATED LINKS
