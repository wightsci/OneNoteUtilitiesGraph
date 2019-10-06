# OneNoteUtilitiesGraph
PowerShell module for manipulating [Microsoft OneNote](https://www.onenote.com/) data using the Microsoft Graph REST API.

Following on from OneNoteUtilities this module uses the Microsoft Graph API instead of the desktop COM objects.

This module provides the following functions:

* [Get-ONConfig](docs/Get-ONConfig.md)
* [Get-ONDefaultSection](docs/Get-ONDefaultSection.md)
* [Get-ONElement](docs/Get-ONElement.md)
* [Get-ONNoteBook](docs/Get-ONNoteBook.md)
* [Get-ONNoteBooks](docs/Get-ONNoteBooks.md)
* [Get-ONPage](docs/Get-ONPage.md)
* [Get-ONPagePreview](docs/Get-ONPagePreview.md)
* [Get-ONPages](docs/Get-ONPages.md)
* [Get-ONPageXML](docs/Get-ONPageXML.md)
* [Get-ONRecentNoteBooks](docs/Get-ONRecentNoteBooks.md)
* [Get-ONResource](docs/Get-ONResource.md)
* [Get-ONResources](docs/Get-ONResources.md)
* [Get-ONSection](docs/Get-ONSection.md)
* [Get-ONSectionGroup](docs/Get-ONSectionGroup.md)
* [Get-ONSectionGroups](docs/Get-ONSectionGroups.md)
* [Get-ONSections](docs/Get-ONSections.md)
* [Get-ONSessionVariables](docs/ONGet-SessionVariables.md)
* [Get-ONTokenStatus](docs/Get-ONTokenStatus.md)
* [Invoke-ONApp](docs/Invoke-ONApp.md)
* [Invoke-ONWeb](docs/Invoke-ONWeb.md)
* [New-ONElement](docs/New-ONElement.md)
* [New-ONNoteBook](docs/New-ONNoteBook.md)
* [New-ONPage](docs/New-ONPage.md)
* [New-ONPageXML](docs/New-ONPageXML.md)
* [New-ONSection](docs/New-ONSection.md)
* [New-ONSectionGroup](docs/New-ONSectionGroup.md)
* [Remove-ONPage](docs/Remove-ONPage.md)
* [Save-ONConfig ](docs/ONSave-Config.md)
* [Set-ONPageLevel](docs/Set-ONPageLevel.md)
* [Test-ONUtilities](docs/Test-ONUtilities.md)
* [Update-ONElement](docs/Update-ONElement.md)
* ~Remove-ONNoteBook~
* ~Remove-ONSectionGroup~
* ~Remove-ONSection~
* ~Remove-ONElement~
* ~Copy-ONPage~

## Installation

Before installing the module, ensure that you have a client ID for the Microsoft Graph service. See the following for more information [https://docs.microsoft.com/en-us/graph/auth-register-app-v2](https://docs.microsoft.com/en-us/graph/auth-register-app-v2).

Create a config XML file containing your client ID and security scope information, named OneNoteUtilities.config and place it in your .config folder.
There is a [template file](https://raw.githubusercontent.com/wightsci/OneNoteUtilitiesGraph/master/OneNoteUtilities.config) in this repo on GitHub.

Download the module, extract it to a location in your modules path and use ```Import-Module```. The process of importing will trigger an attempt to connect to Microsoft Graph. *This will fail if you haven't set up the config file*. 

## Use Case - Creating Structure

Suppose that you need to create a new Notebook, create Sections for the months of the year and create a Page for each day of each month. You would like the title of each page to look like 'Friday, 26th June 2019' in format. With OneNoteUtiliesGraph you can do this:

```powershell
Import-Module OneNoteUtilitiesGraph
#Create NoteBook
$NoteBook = New-ONNoteBook -DisplayName (Get-Date).Year
#Create Section per Month
(1..12) | % {
    $month = $_; 
    $monthName = (Get-Date -Month $_).ToString('MMMM')
    $Section = New-ONSection -Id $NoteBook.Id -DisplayName $monthName
    #Create Page per Day 
    (1..$([DateTime]::DaysInMonth((Get-Date).Year,$month))) | % {
            $Page = New-ONPageXML -Title $((Get-Date -Year (Get-Date).Year -Month $month -Day $_).toString("dddd dd MMMM yyyy"))
            New-ONPage -URI $Section.pagesURL -Page $Page
    }
}
```
It takes a couple of minutes, but that's much shorter than creating 12 month Sections and 365 day Pages by hand.

This could just as easily be applied to lists of staff, students or objects in Active Directory.

## Use Case - Querying


```powershell
Get-ONPages -Filter "parentNoteBook/displayname eq '2019' and startswith(title,'Monday')"
```

## More use cases - see the Wiki

[https://github.com/wightsci/OneNoteUtilitiesGraph/wiki](https://github.com/wightsci/OneNoteUtilitiesGraph/wiki)

## Future Developments

* Support for Tags
* HTML Templates for Pages
* Merge-to-OneNote
* Out-ONPage
* New Graph REST features as they are released