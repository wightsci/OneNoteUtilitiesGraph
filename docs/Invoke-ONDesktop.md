---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Invoke-ONDesktop

## SYNOPSIS
Invokes the Office 365 OneNote application and loads a page.

## SYNTAX

### page (Default)
```
Invoke-ONDesktop [-Page] <Object> [<CommonParameters>]
```

### id
```
Invoke-ONDesktop [-Id] <String> [<CommonParameters>]
```

## DESCRIPTION
Invokes the Office 365 OneNote application and loads a page. This command specifically loads the *desktop* version of OneNote, rather than whichever application is registered with WIndows as the handler of the `onenote:` protocol.

## EXAMPLES

### Example 1
```powershell
PS C:\>  Invoke-ONDesktop -Page (Get-ONPages -Filter "title eq '2 - Life Cycle of Tree Frog'")
```

This command uses **Get-ONPages** to obtain a Page object matching the filter, and this is passed to **Invoke-ONDesktop**

### Example 2
```powershell
PS C:\> Invoke-ONDesktop -ID ' 0-634cb14d92da4a1c85ca21fccb057cf7!40-816F7725BEF00A5F!665030'
```

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

### System.Object
## NOTES

## RELATED LINKS
