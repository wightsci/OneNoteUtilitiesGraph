# Gets the default OneNote Section for new content creation
Function Get-ONDefaultSection {
    Get-ONSections -filter "isDefault eq true"
}
    