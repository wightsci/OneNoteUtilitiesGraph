---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Invoke-ONApp

## SYNOPSIS
Invokes the default handler for onenote: URLs and loads a page.

## SYNTAX

### page (Default)
```
Invoke-ONApp [-Page] <Object> [<CommonParameters>]
```

### id
```
Invoke-ONApp [-Id] <String> [<CommonParameters>]
```

## DESCRIPTION
Invokes the default application for handling 'onenote:' URLs and passes it the URL of a page to load, based on an ID or a Page object.

## EXAMPLES

### Example 1
```powershell
PS C:\>  Invoke-ONApp -Page (Get-ONPages -Filter "title eq '2 - Life Cycle of Tree Frog'")
```

This command uses **Get-ONPages** to obtain a Page object matching the filter, and this is passed to **Invoke-ONApp**

### Example 2
```powershell
PS C:\> Invoke-ONApp -ID ' 0-634cb14d92da4a1c85ca21fccb057cf7!40-816F7725BEF00A5F!665030'
```

This command opens a Page based on its ID.

## PARAMETERS

### -Id
The ID of the page to be loaded.

```yaml
Type: String
Parameter Sets: id
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
A Page object to be loaded.

```yaml
Type: Object
Parameter Sets: page
Aliases:

Required: True
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

### None
## NOTES

## RELATED LINKS
