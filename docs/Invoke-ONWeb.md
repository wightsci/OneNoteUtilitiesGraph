---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Invoke-ONWeb

## SYNOPSIS
Invokes the default web browser application and loads a page.

## SYNTAX

### page (Default)
```
Invoke-ONWeb -Page <Object> [<CommonParameters>]
```

### Id
```
Invoke-ONWeb -Id <Object> [<CommonParameters>]
```

## DESCRIPTION
Invokes the default application for handling web pages and passes it the URL of a page to load, based on an ID or a Page object.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ONWeb -Page (Get-ONPages -Filter "title eq '2 - Life Cycle of Tree Frog'")
```

This command uses Get-ONPages to obtain a Page object matching the filter, and this is passed to Invoke-ONWeb

### Example 2
```
PS C:\> Invoke-ONWeb -ID ' 0-634cb14d92da4a1c85ca21fccb057cf7!40-816F7725BEF00A5F!665030'
```

This command opens a Page based on its ID.

## PARAMETERS

### -Id
{{ Fill Id Description }}

```yaml
Type: Object
Parameter Sets: Id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
{{ Fill Page Description }}

```yaml
Type: Object
Parameter Sets: page
Aliases:

Required: True
Position: Named
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
## NOTES

## RELATED LINKS
[Invoke-ONApp](Invoke-ONApp.md)