---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# New-ONPage

## SYNOPSIS
Creates a new OneNote Page.

## SYNTAX

### page
```
New-ONPage [-Uri <String>] -Page <Object> [<CommonParameters>]
```

### html
```
New-ONPage [-Uri <String>] -Html <String> [<CommonParameters>]
```

## DESCRIPTION
Creates a new OneNote Page.

## EXAMPLES

### Example 1
```
PS C:\> $p = New-ONPageXML -Title 'Lesson 1'
PS C:\> New-ONPage -URI 'https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!731583/pages' -page $p

@odata.context       : https://graph.microsoft.com/v1.0/$metadata#users('me')/onenote/sections('0-816F7725BEF00A5F%21731583')/pages/$entity
id                   : 0-b9b9988092b24ac0bb14d4953f88ca2f!61-816F7725BEF00A5F!731583
self                 : https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-b9b9988092b24ac0bb14d4953f88ca2f!61-816F7725BEF00A5F!731583
createdDateTime      : 2019-06-27T15:17:35.9924696Z
title                : Lesson 1
createdByAppId       : WLID-00000000441C65F3
contentUrl           : https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-b9b9988092b24ac0bb14d4953f88ca2f!61-816F7725BEF00A5F!731583/content
lastModifiedDateTime : 2019-06-27T15:17:35.9924696Z
links                : @{oneNoteClientUrl=; oneNoteWebUrl=}
```

This example shows the creation of an XHTML page using `New-ONPageXML` that is then passed to `New-ONPage` for creation in the Graph service.

## PARAMETERS

### -Page
A Page object.

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

### -Html
The page content as valid XHTML.

```yaml
Type: String
Parameter Sets: html
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
The location to create the new Page.

If no location is specified then the default location for new content is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-ONDefaultSection).pagesUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-ONDefaultSection]()
[New-ONPageXML]()
