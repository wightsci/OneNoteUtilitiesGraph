# OneNoteUtilitiesGraph
OneNote module for PowerShell using the Graph REST API

Following on from OneNoteUtilities this module uses the Microsoft Graph API instead of the desktop COM objects.

This module provides the following functions:

* Get-ONDefaultSection
* Get-ONElement
* Get-ONPage
* Get-ONPagePreview
* Get-ONPages
* Get-ONPageXML
* Get-ONNoteBook
* Get-ONNoteBooks
* Get-ONSectionGroup
* Get-ONSectionGroups
* Get-ONSection
* Get-ONSections
* Get-ONResource
* Get-ONResources
* New-ONElement
* New-ONPage
* New-ONPageXML
* New-ONNoteBook
* New-ONSectionGroup
* New-ONSection
* Invoke-ONApp
* Invoke-ONWeb
* ~Remove-ONNoteBook~
* ~Remove-ONSectionGroup~
* ~Remove-ONSection~
* Remove-ONPage
* ~Remove-ONElement~
* ~Copy-ONPage~
* Set-ONPageLevel
* Get-ONRecentNoteBooks

## Installation

Before installing the module, ensure that you have a client ID for the Microsoft Graph service.

Create a config XML file containing your client ID and security scope information, named OneNoteUtilities.config and place it in you .config folder.
There is a [template file](https://raw.githubusercontent.com/wightsci/OneNoteUtilitiesGraph/master/OneNoteUtilities.config) on GitHub.

Download the module, extract it to a location in your modules path and use ```Import-Module```. The process of importing will trigger an attempt to connect to Microsoft Graph. *This will fail if you haven't set up the config file*. 
