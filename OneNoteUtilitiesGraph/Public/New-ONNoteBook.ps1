# Create a new OneNote NoteBook
Function New-ONNoteBook {
    Param (
        [Parameter(Mandatory=$true)]
        [string]$DisplayName
    )
    $uri = "{0}{1}" -f $ONuri, 'notebooks'
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "NoteBook"
    Return $response
}
