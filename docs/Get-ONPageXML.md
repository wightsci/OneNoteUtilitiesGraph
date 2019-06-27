---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONPageXML

## SYNOPSIS
Gets the XHTML source of a OneNote Page.

## SYNTAX

```
Get-ONPageXML [-Page] <Object> [<CommonParameters>]
```

## DESCRIPTION
Gets the XHTML source of a OneNote Page.
This cmdlet automatically requests element IDs to aid in page updates.

## EXAMPLES

### EXAMPLE 1
```
Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML | Select-Object -Expand OuterXml

<html lang="en-US">
        <head>
                <title>ePortfolio</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        </head>
        <body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">
                <div id="div:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{36}" style="position:absolute;left:48px;top:115px;width:590px">
                        <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{34}" style="margin-top:0pt;margin-bottom:0pt">OneNote makes it easy to <span style="font-weight:bold">track student</span> <span style="font-weight:bold">progress</span> in one notebook.
You can easily track items like <span style="font-weight:bold">homework</span>, <span style="font-weight:bold">quizzes</span>, and <span style="font-weight:bold">tests</span> for all your students. 
Some teachers create a notebook for each student in the class. 
Then they can put homework, quizzes, tests and even a copies of a group project into this ePortfolio.
</p>
                        <br />
                        <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35}" style="margin-top:0pt;margin-bottom:0pt">For quizzes and tests, you can track the items that students either get consistently wrong or consistently correct.
You can even keep copies of the student's completed quizzes or tests in case you want to refer to them later.
</p>
                        <br />
                        <img id="img:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{40}" width="708" height="418" src="https://graph.microsoft.com/v1.0/users('me')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value" data-src-type="image/png" data-fullres-src="https://graph.microsoft.com/v1.0/users('me')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value" data-fullres-src-type="image/png" />
                </div>
        </body>
</html>
```

This command pipes a Page object to Get-ONPageXML.
Expanding the 'html' property displays the full XHTML of the page.

### EXAMPLE 2
```
$page = Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML
$page.GetElementsByTagName('p')

id                                           style                            #text
--                                           -----                            ----- 
p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{34} margin-top:0pt;margin-bottom:0pt {OneNote makes it easy to ,  in one notebook.
You can easily track items like , , , , and ...} 
p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35} margin-top:0pt;margin-bottom:0pt For quizzes and tests, you can track the items that students either get consistently wrong or consistently correct.
You can eve...
```

This command pipes a Page object to Get-ONPageXML and stores the result in the variable $page.
$page can then be accessed as an XMLDocument object.

## PARAMETERS

### -Page
A OneNote Page object.
Must have a 'contentURL' property.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Object representing a Page resource. Must have a 'contentURL' property.
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-ONPage]()

[Get-ONPages]()

[Get-ONElement]()

