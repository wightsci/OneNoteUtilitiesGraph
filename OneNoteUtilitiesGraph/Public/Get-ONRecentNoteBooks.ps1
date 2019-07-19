# Get a list of recently accessed OneNote NoteBooks
Function Get-ONRecentNoteBooks {
    $uri = "{0}{1}" -f $ONuri, 'notebooks/getrecentnotebooks(includePersonalNotebooks=true)'
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method Get
    Return $response.value
}