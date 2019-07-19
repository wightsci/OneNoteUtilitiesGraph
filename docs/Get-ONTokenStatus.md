---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONTokenStatus

## SYNOPSIS
Checks for presence of Auth Code and Access Token.

If not present or expired then requests new.

## SYNTAX

```
Get-ONTokenStatus [<CommonParameters>]
```

## DESCRIPTION
This function maintains a valid set of Graph credentials, comprising an Authorization Code and an Access Token.

TYpically this function is called before any access is attempted to the Graph API itself.

## EXAMPLES

### Example 1
```
PS C:\> Get-ONTokenStatus
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-ONAuthCode]()

[Get-ONAccessToken]()

