---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Set-ONPageLevel

## SYNOPSIS
Sets the page indentation level of a OneNote Page.

## SYNTAX

```
Set-ONPageLevel [-Id] <String> [-Level] <Object> [<CommonParameters>]
```

## DESCRIPTION
Sets the page indentation level of a OneNote Page.
Not applicable to the first Page in a Section.

## EXAMPLES

### Example 1
```
PS C:\> Set-ONPageLevel -ID '0-b9b9988092b24ac0bb14d4953f88ca2f!61-816F7725BEF00A5F!731583' -Level 1
```

This command indents the PageLevel of the given Page to level 1.
This will only succeed if the Page is not the first one in the Section.

## PARAMETERS

### -Id
The Id of the OneNote Page.

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

### -Level
The level for the page.
Possible values:

0,1,2

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-ONPage](Get-ONPage.md)

