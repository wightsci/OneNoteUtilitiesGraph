---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Update-ONElement

## SYNOPSIS
Updates a specified element on a OneNote Page.

## SYNTAX

```
Update-ONElement [-Id] <String> [-TargetId] <String> [-Action] <String> [-Content] <String>
 [[-Position] <String>] [<CommonParameters>]
```

## DESCRIPTION
Updates a specified element on a OneNote Page, identified by its ID.

## EXAMPLES

### EXAMPLE 1
```
$page = Get-ONPages -Filter "title eq 'Project Zero Work List'" | Get-ONPageXML
$page.OuterXML

 <html lang="en-GB">
    <head>
        <title>Project Zero Work List</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="created" content="2019-06-26T11:35:00.0000000" />         
    </head>         
    <body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">
        <div id="div:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{29}" style="position:absolute;left:48px;top:115px;width:576px">
            <p id="p:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{31}" style="margin-top:0pt;margin-bottom:0pt">Implementation needs to be completed by 1st July 2019</p>
        </div>         
    </body> 
</html>

Update-ONElement -TargetID 'p:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{31}' -Id 0-3f5159c19028036127617e60b3e94771!1-816F7725BEF00A5F!1079 -action replace -content '<p>Implementation needs to be completed by 1st December 2019</p>' 
$page = Get-ONPages -Filter "title eq 'Project Zero Work List'" | Get-ONPageXML
$page.OuterXML 
<html lang="en-GB">
    <head>                 
        <title>Project Zero Work List</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="created" content="2019-06-26T11:35:00.0000000" />
    </head>         
    <body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">                 
        <div id="div:{5071e2d9-b596-0397-0473-9e65c6a6ede6}{29}" style="position:absolute;left:48px;top:115px;width:576px">                         
            <p id="p:{e67fb9a8-e119-4610-9812-7249f47331bd}{142}" lang="en-US" style="margin-top:5.5pt;margin-bottom:5.5pt">Implementation needs to be completed by 1st December 2019</p>          
        </div>         
    </body> 
</html>
```

In this example we first retrieve the XML content of a page using Get-ONPages and Get-ONPageXML, then we update the content of a paragraph element.
We then re-retrieve the page to check that the content has changed.
Note that the Id of the paragraph is changed because we are replacing it.

## PARAMETERS

### -Id
The ID of the page to be modified.

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

### -Action
The action to be undertaked.
Possible values:  replace, append, delete, insert, or prepend

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
The XHTML content for the Action.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position
The location of the content in relation to the target.
Possible values: after (default) or before

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetId
The ID of the Page element to be updated, or the 'body' or 'title' keyword.

```yaml
Type: String
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

[Get-ONPageXML](Get-ONPageXML.md)

[Get-ONPages](Get-ONPages.md)

[Get-ONPage](Get-ONPage)

