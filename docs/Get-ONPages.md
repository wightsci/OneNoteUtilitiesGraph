# Get-ONPages

## SYNOPSIS
Gets a list of OneNote Pages matching the given Filter, or found at the given URL.

## SYNTAX

### filter
```
Get-ONPages [-Filter <String>] [<CommonParameters>]
```

### uri
```
Get-ONPages [-Uri <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a list of OneNote Pages matching the given Filter or found at the given URL.
The filter
should be valid OData.
The information returned is the standard set of Graph metadata for a Page object.

## EXAMPLES

### EXAMPLE 1
```
Get-ONPages -Filter "startswith(title,'OneNote')" | Select-Object Id,Title

id                                                            title
--                                                            -----
0-1f9aa8a73e9a4f14b4daa7762b5aa530!42-816F7725BEF00A5F!665027 OneNote Class Notebooks
0-634cb14d92da4a1c85ca21fccb057cf7!39-816F7725BEF00A5F!665030 OneNote in Education Resources
0-8d3847e53f7d452aaddc4f63814b8d59!11-816F7725BEF00A5F!1079   OneNote Clipper Installation
0-bf55e9873b624c5c98d779f0e9f6e6d1!21-816F7725BEF00A5F!665031 OneNote and Learning Styles

```

This command gets a list of pages whose Title starts with 'OneNote'.

### EXAMPLE 2
```
Get-ONPages -Uri 'https://graph.microsoft.com/v1.0/users/me/onenote/sections/0-816F7725BEF00A5F!665031/pages' | Select-Object Id,Title

id                                                            title
--                                                            -----
0-bf55e9873b624c5c98d779f0e9f6e6d1!44-816F7725BEF00A5F!665031 Other Learning Activities
0-bf55e9873b624c5c98d779f0e9f6e6d1!60-816F7725BEF00A5F!665031 Facilitator Guides
0-bf55e9873b624c5c98d779f0e9f6e6d1!54-816F7725BEF00A5F!665031 Self-Paced Teacher Development
0-bf55e9873b624c5c98d779f0e9f6e6d1!49-816F7725BEF00A5F!665031 Courses Delivered in OneNote
0-bf55e9873b624c5c98d779f0e9f6e6d1!57-816F7725BEF00A5F!665031 New Teacher Orientation
0-bf55e9873b624c5c98d779f0e9f6e6d1!28-816F7725BEF00A5F!665031 Teacher Workbooks
0-bf55e9873b624c5c98d779f0e9f6e6d1!17-816F7725BEF00A5F!665031 Example Lesson Plans
0-bf55e9873b624c5c98d779f0e9f6e6d1!63-816F7725BEF00A5F!665031 How OneNote Enhances Different Learning Styles
0-bf55e9873b624c5c98d779f0e9f6e6d1!21-816F7725BEF00A5F!665031 OneNote and Learning Styles
0-bf55e9873b624c5c98d779f0e9f6e6d1!46-816F7725BEF00A5F!665031 Variety of Education and Learning Examples
0-bf55e9873b624c5c98d779f0e9f6e6d1!51-816F7725BEF00A5F!665031 ePortfolio
```
This command gets a list of Pages found at a specific URL.

## PARAMETERS

### -Filter
The filter to use for the Page list.
OData.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
The location to obtain the pages from.

```yaml
Type: String
Parameter Sets: uri
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

### None. You cannot pipe to this cmdlet.
## OUTPUTS

### PSCustomObject collection representing Graph Page resources.
## NOTES

## RELATED LINKS

[Get-ONPage]()

[Get-ONPageXML]()

