function Get-ONTableAsObject {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        $Table,
        [Switch]$NoHeaders
    )
    $cols = $table.tr[0].td.Count
    $rows = $table.tr.Count
    
    Write-Debug "Rows: $rows, Columns: $cols"
    
    $tableObject = [System.Collections.ArrayList]@()
    $headers = @()
    
    if ($NoHeaders.IsPresent) {
    for ( $h = 0; $h -lt $cols; $h++ ) {
            $headers += ("Column $h")
        }
    
    }
    else {
               
        for ( $h = 0; $h -lt $cols; $h++ ) {
            $headers += ($table.tr[0].td[$h].InnerText)
        }

    }
    
    
    for ($i = 0; $i -lt $rows; $i++) {
        
        $rowObject = New-Object PSCustomObject
        
        if (!$NoHeaders.IsPresent -and $i -eq 0) {
      
        }
        else {
            
            for ($c = 0 ; $c -lt $cols; $c++) { 
                Write-Debug "Row $i, Column $c"
                $rowObject | Add-Member -MemberType NoteProperty -Name $headers[$c] -Value $table.tr[$i].td[$c].InnerText
    
            }
            [Void]$tableObject.Add($rowObject)
        }
    
    }
    
    return $tableObject 
}