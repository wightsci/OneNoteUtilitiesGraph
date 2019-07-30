# Get a Graph Authcode, using a web form if required
Function Get-ONAuthCode {
    [cmdletbinding()]
    Param()
        Add-Type -AssemblyName System.Windows.Forms  
        $form = New-Object -TypeName System.Windows.Forms.Form -Property @{Width=440;Height=640}
        $web  = New-Object -TypeName System.Windows.Forms.WebBrowser -Property @{Width=420;Height=600;Url=$authURI}
        
        $DocComp  = {
            $Global:authURI = $web.Url.AbsoluteUri  
            if ($Global:authURI -match "error=[^&]*|code=[^&]*") {
                Write-Verbose "Closing. URL: $($Global:AuthURI)"
                $form.Close() 
            }
        }
    
        $web.ScriptErrorsSuppressed = $true
        $web.Add_DocumentCompleted($DocComp)
        $form.Controls.Add($web)
        $form.Add_Shown({$form.Activate()})
        $form.ShowDialog() | Out-Null
        $Global:authQuery = $web.url.Query
        Write-Verbose $web.Url.Query
    }
    