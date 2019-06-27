---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Invoke-ONWeb

## SYNOPSIS
Invokes the default web browser and loads a page.

## SYNTAX

### page
```
Invoke-ONWeb [-page <Object>] [<CommonParameters>]
```

### Id
```
Invoke-ONWeb [-Id <Object>] [<CommonParameters>]
```

## DESCRIPTION
Invokes the default application for handling web urls and passes it the URL
of a page to load, based on an ID or a Page object.

### Example 1
```
PS C:\> Invoke-ONWeb -Page (Get-ONPages -Filter "title eq '2 - Life Cycle of Tree Frog'")
```

This command uses ```Get-ONPages``` to obtain a Page object matching the filter, and this is passed to ```Invoke-ONApp```

### Example 2
```
PS C:\> Invoke-ONWeb-ID ' 0-634cb14d92da4a1c85ca21fccb057cf7!40-816F7725BEF00A5F!665030'
```

This command uses opens a Page based on its ID.

## PARAMETERS

### -page
A OneNote Page object.

```yaml
Type: Object
Parameter Sets: page
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The Id of a OneNote Page.

```yaml
Type: Object
Parameter Sets: Id
Aliases:

Required: False
Position: Named
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
