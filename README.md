# OneNoteUtilitiesGraph
OneNote module for PowerShell using the Graph REST API

Following on from OneNoteUtilities this module uses the Microsoft Graph API instead of the desktop COM objects.

This module provides the following functions:

* [Get-Config](docs/Get-Config.md)
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
* [Get-SessionVariables](docs/Get-SessionVariables.md)
* [Get-TokenStatus](docs/Get-TokenStatus.md)
* [Invoke-ONApp](docs/Invoke-ONApp.md)
* [Invoke-ONWeb](docs/Invoke-ONWeb.md)
* [New-ONElement](docs/New-ONElement.md)
* [New-ONNoteBook](docs/New-ONNoteBook.md)
* [New-ONPage](docs/New-ONPage.md)
* [New-ONPageXML](docs/New-ONPageXML.md)
* [New-ONSection](docs/New-ONSection.md)
* [New-ONSectionGroup](docs/New-ONSectionGroup.md)
* [Remove-ONPage](docs/Remove-ONPage.md)
* [Save-Config ](docs/Save-Config.md)
* [Set-ONPageLevel](docs/Set-ONPageLevel.md)
* [Test-ONUtilities](docs/Test-ONUtilities.md)
* [Update-ONElement](docs/Update-ONElement.md)
* ~Remove-ONNoteBook~
* ~Remove-ONSectionGroup~
* ~Remove-ONSection~
* ~Remove-ONElement~
* ~Copy-ONPage~

## Installation

Before installing the module, ensure that you have a client ID for the Microsoft Graph service.

Create a config XML file containing your client ID and security scope information, named OneNoteUtilities.config and place it in you .config folder.
There is a [template file](https://raw.githubusercontent.com/wightsci/OneNoteUtilitiesGraph/master/OneNoteUtilities.config) on GitHub.

Download the module, extract it to a location in your modules path and use ```Import-Module```. The process of importing will trigger an attempt to connect to Microsoft Graph. *This will fail if you haven't set up the config file*. 
