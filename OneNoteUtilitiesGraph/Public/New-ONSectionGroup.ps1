# Create a new OneNote Section Group
Function New-ONSectionGroup {
    Param(
        [Parameter(ParameterSetName = 'ByID', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ByUri', Mandatory = $true)]
        [string]$DisplayName,
        [Parameter(ParameterSetName = 'ByUri', Mandatory = $true)]
        [string]$Uri,
        [Parameter(ParameterSetName = 'ByID', Mandatory = $true)]
        [string]$Id
    )
    if ($id) {
        $uri = "{0}notebooks/{1}/sectiongroups" -f $ONuri, $id
    }
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken" } -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "SectionGroup"
    Return $response
}
