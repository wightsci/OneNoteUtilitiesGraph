Function Save-ONConfig {
    [CmdletBinding()]
        Param(
            [string]$path="$HOME\.config\OneNoteUtilities.config",
            [switch]$Force
        )
        $config = [xml]'<?xml version="1.0"?><settings></settings>'
        foreach ($node in $settings.Keys) {
            $setting = $config.CreateElement('setting')
            $setting.SetAttribute('name',$node)
            $setting.SetAttribute('value',$settings[$node])
            $config['settings'].AppendChild($setting) | Out-Null
        }
        if ((Test-Path $path) -and (!$Force.IsPresent)) {
            Throw "Config file exists"
        }
        else {
        $config.Save($path)
        }
    }
    