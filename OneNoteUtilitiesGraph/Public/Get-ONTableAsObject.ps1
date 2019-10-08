function Get-ONTableAsObject {
    [CmdletBinding()]
    Param(
        $table,
        $tableHasHeaders=1
    )
    $cols = $t.tr[0].td.Count
    $rows = $t.tr.Count
    
    Write-Debug "Rows: $rows, Columns: $cols"
    
    $tableObject = [System.Collections.ArrayList]@()
    $headers = @()
    
    if ($tableHasHeaders) {
            
        for ( $h = 0; $h -lt $cols; $h++ ) {
            $headers += ($table.tr[0].td[$h].InnerText)
        }

    }
    else {
               
        for ( $h = 0; $h -lt $cols; $h++ ) {
            $headers += ("Column $h")
        }
    
    }
    
    
    for ($i = 0; $i -lt $rows; $i++) {
        
        $rowObject = New-Object PSCustomObject
        
        if ($tableHasHeaders -and $i -eq 0) {
      
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