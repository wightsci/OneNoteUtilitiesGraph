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

### page

```PowerShell
Get-ONPageXML [-Page] <Object> [-AsText] [<CommonParameters>]
```

### id

```powershell
Get-ONPageXML -Id <Object> [-AsText] [<CommonParameters>]
```

## DESCRIPTION
Gets the XHTML source of a OneNote Page.
This cmdlet automatically requests element IDs to aid in page updates.

## EXAMPLES

### EXAMPLE 1
```
Get-ONPage -uri 'https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML | Select-Object -Expand OuterXml

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

This command pipes a Page object to **Get-ONPageXML**.
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

This command pipes a Page object to **Get-ONPageXML** and stores the result in the variable $page.
$page can then be accessed as an XMLDocument object.

### EXAMPLE 3
```
Get-ONPage -uri ' https://graph.microsoft.com/v1.0/users/me/onenote/pages/0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' | Get-ONPageXML -AsText
    <html lang="en-US">
            <head>
                    <title>ePortfolio</title>
                    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            </head>
            <body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">
                    <div id="div:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{36}" style="position:absolute;left:48px;top:115px;width:590px">
                            <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{34}" style="margin-top:0pt;margin-bottom:0pt">OneNote makes it easy to <span style="font-weight:bold">track student</span> <span
    style="font-weight:bold">progress</span> in one notebook. You can easily track items like <span style="font-weight:bold">homework</span>, <span style="font-weight:bold">quizzes</span>, and <span
    style="font-weight:bold">tests</span> for all your students.  Some teachers create a notebook for each student in the class.  Then they can put homework, quizzes, tests and even a copies of a group project
    into this ePortfolio. </p>
                            <br />
                            <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35}" style="margin-top:0pt;margin-bottom:0pt">For quizzes and tests, you can track the items that students either get consistently
    wrong or consistently correct. You can even keep copies of the student's completed quizzes or tests in case you want to refer to them later. </p>
                            <br />
                            <img id="img:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{40}" width="708" height="418"
    src="https://graph.microsoft.com/v1.0/users('me')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value" data-src-type="image/png"
    data-fullres-src="https://graph.microsoft.com/v1.0/users('me')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value" data-fullres-src-type="image/png" />
                    </div>
            </body>
    </html>
```

This command pipes a page object to **Get-ONPageXML**. The -AsText switch means that the output is a string rather than an XML document.

### EXAMPLE 4
```
Get-ONPageXML -Id 0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031' -AsText

<html lang="en-US">
<head>
    <title>ePortfolio</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body data-absolute-enabled="true" style="font-family:Calibri;font-size:11pt">
    <div id="div:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{36}" style="position:absolute;left:48px;top:115px;width:590px">
        <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{34}" style="margin-top:0pt;margin-bottom:0pt">OneNote makes it
            easy to <span style="font-weight:bold">track student</span> <span style="font-weight:bold">progress</span>
            in one notebook. You can easily track items like <span style="font-weight:bold">homework</span>, <span
                style="font-weight:bold">quizzes</span>, and <span style="font-weight:bold">tests</span> for all your
            students. Some teachers create a notebook for each student in the class. Then they can put homework,
            quizzes, tests and even a copies of a group project into this ePortfolio. </p> <br />
        <p id="p:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{35}" style="margin-top:0pt;margin-bottom:0pt">For quizzes and
            tests, you can track the items that students either get consistently wrong or consistently correct. You can
            even keep copies of the student's completed quizzes or tests in case you want to refer to them later. </p>
        <br /> <img id="img:{ebb53e77-c34a-4a11-ad64-7c7fff9d7562}{40}" width="708" height="418"
            src="https://graph.microsoft.com/v1.0/users('stuart_squibb@hotmail.co.uk')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value"
            data-src-type="image/png"
            data-fullres-src="https://graph.microsoft.com/v1.0/users('stuart_squibb@hotmail.co.uk')/onenote/resources/0-d0b17facd3c241aa886959406a8c352c!1-816F7725BEF00A5F!665031/$value"
            data-fullres-src-type="image/png" />
    </div>
</body>
</html>
```

This command retrieves the content of a page using **Get-ONPageXML** and the Id parameter. The -AsText switch means that the output is a string rather than an XML document.

### EXAMPLE 5
```
Get-ONPageXML -Id '0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031'          

html
----
html
```
This command retrieves the content of a page using **Get-ONPageXML** and the Id parameter. The result is a System.Xml.XmlDocument object. You would normally store this in a variable for further processing.

## PARAMETERS

### -Page
A OneNote Page object.
Must have a 'contentURL' property.

```yaml
Type: Object
Parameter Sets: page
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -AsText
A switch parameter, that if supplied, tells the cmdlet to output the page content a text, rather than an XMLDocument object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The Id of the page you wish to retrieve the content of.

```yaml
Type: Object
Parameter Sets: id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [PSCustomObject]
Representing a Page resource. Must have a 'contentURL' property.

## OUTPUTS

### XMLDocument
XHTML document object

### String

## NOTES

## RELATED LINKS

[Get-ONPage]()

[Get-ONPages]()

[Get-ONElement]()

