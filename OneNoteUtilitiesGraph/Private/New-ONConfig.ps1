function New-ONConfig {
    Param(
        [string]$ClientID
    )
[xml]$configtemplate = @"
<?xml version="1.0"?>
<settings>
  <setting name="scope" value="https://graph.microsoft.com/Notes.ReadWrite https://graph.microsoft.com/Notes.Create" />
  <setting name="clientid" value="$clientid" />
</settings>
"@
$path="$HOME\.config\OneNoteUtilities.config"
$configtemplate.Save($path)
}