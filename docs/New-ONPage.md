# New-ONPage

## SYNOPSIS
Creates a new OneNote Page.

## SYNTAX

### page
```
New-ONPage [-URI <String>] [-Page <Object>] [<CommonParameters>]
```

### html
```
New-ONPage [-URI <String>] [-html <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new OneNote Page.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -URI
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

### -html
The page content as valid XHTML.

```yaml
Type: String
Parameter Sets: html
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
A Page object.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
