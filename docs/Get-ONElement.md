---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONElement

## SYNOPSIS
Gets an element from a OneNote Page.

## SYNTAX

```
Get-ONElement [-Id] <String> [-Page] <Object> [<CommonParameters>]
```

## DESCRIPTION
Gets an element from a OneNote Page.
Returned as an XML element.

## EXAMPLES

### EXAMPLE 1
```
$page = Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML
Get-ONElement -page $page -id 'p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35}'

id                                           style                            #text
--                                           -----                            -----
p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35} margin-top:0pt;margin-bottom:0pt For quizzes and tests, you can track the items that students either get consistently wrong or consistently correct.
You can eve...
```

This command obtains the content of a Page and stores it in the variable $page.
Get-ONElement is then used to return a particular paragraph element.

## PARAMETERS

### -Id
The Id of the page element.

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

### -Page
The page object hosting the element.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### You can pipe an XHTML Page resource to this cmdlet, such as the output from Get-ONPageXML
## OUTPUTS

### An XMLElement object.
## NOTES

## RELATED LINKS

[Get-ONPage](Get-ONPage.md)

[Get-ONPageXML](Get-ONPageXML.md)

[Get-ONPages](Get-ONPages.md)

