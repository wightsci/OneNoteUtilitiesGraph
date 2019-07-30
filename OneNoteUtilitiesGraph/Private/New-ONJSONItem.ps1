Function New-ONJSONItem {
    Param(
        $Hashtable
    )
    $workJSOn = $hashtable | ConvertTo-Json
    Return $workJSON
}