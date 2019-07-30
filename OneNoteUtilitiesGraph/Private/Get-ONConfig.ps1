Function Get-ONConfig {
    Param(
        [string]$Path="$HOME\.config\OneNoteUtilities.config"
    )
    $Global:settings = @{}
    if (Test-Path $path) {
        $config = [xml](Get-Content $path)
        foreach ($node in $config.settings.setting) {
            $value = $node.Value
            $Global:settings[$node.Name] = $value
        }
    }
    Else {
        Write-Error "No config file found. Please create one."
        Exit
    }
}