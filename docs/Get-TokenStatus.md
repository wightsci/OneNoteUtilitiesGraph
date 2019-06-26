# Get-TokenStatus

## SYNOPSIS
Checks for presence of Auth Code and Access Token.

If not present or expired then requests new.

## SYNTAX

```
Get-TokenStatus [<CommonParameters>]
```

## DESCRIPTION
This function maintains a valid set of Graph credntials, comprising an
Authorization Code and an Access Token.

TYpically this function is called before any access is attempted to the Graph API itself.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
