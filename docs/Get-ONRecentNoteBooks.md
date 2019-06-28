---
external help file: OneNoteUtilitiesGraph-help.xml
Module Name: OneNoteUtilitiesGraph
online version:
schema: 2.0.0
---

# Get-ONRecentNoteBooks

## SYNOPSIS
Gets the list of most recently accessed OneNote Notebooks.

## SYNTAX

```
Get-ONRecentNoteBooks
```

## DESCRIPTION
Gets the list of most recently accessed OneNote Notebooks.

## EXAMPLES

### Example 1
```
PS C:\> Get-ONRecentNoteBooks

displayName         lastAccessedTime     sourceService links
-----------         ----------------     ------------- -----
Work Notebook       2019-06-27T11:33:55Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
API NoteBook        2019-06-26T13:50:46Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
Personal            2019-06-26T10:34:08Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
WebNotes            2019-06-22T17:08:12Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
Real World Samples  2018-10-17T14:17:23Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
Holiday             2018-10-17T14:17:10Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
Main Notebook       2017-05-08T13:14:40Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
Class Notebook      2016-01-21T15:15:31Z OneDrive      @{oneNoteClientUrl=; oneNoteWebUrl=}
```

This command displays the most recently accessed NoteBooks for the logged-on user.

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
