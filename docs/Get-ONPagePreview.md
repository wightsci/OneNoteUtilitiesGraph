---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONPagePreview

## SYNOPSIS
Gets the Graph-generated preview content for a Page.

## SYNTAX

```
Get-ONPagePreview [[-id] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets the Graph-generated preview content for a Page, given its ID

## EXAMPLES

### EXAMPLE 1
```
$page = Get-ONPages -Filter "title eq 'Project Zero Work List'"
```

Get-ONPagePreview -id $page.id

@odata.context                                                                previewText --------------                                                                ----------- https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.onenotePagePreview Implementation needs to be completed b...

## PARAMETERS

### -id
The ID of the Page

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe to this cmdlet.
## OUTPUTS

### PSCustomObject containing preview text and a link to an image, if available
## NOTES

## RELATED LINKS

[Get-ONPages]()

[Get-ONPage]()

