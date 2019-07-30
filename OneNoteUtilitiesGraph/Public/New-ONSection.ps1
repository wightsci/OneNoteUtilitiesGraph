# Create a new OneNote Section
Function New-ONSection {
    Param(
        [Parameter(ParameterSetName='ByID',Mandatory=$true)]
        [Parameter(ParameterSetName='ByUri',Mandatory=$true)]
        [string]$DisplayName,
        [Parameter(ParameterSetName='ByUri',Mandatory=$true)]
        [string]$Uri,
        [Parameter(ParameterSetName='ByID',Mandatory=$true)]
        [string]$Id,
        [Parameter(ParameterSetName="ByID")]
        [switch]$SectionGroup
    )
    if ($id) {
        if ($SectionGroup.IsPresent) {
        $uri = "{0}sectionGroups/{1}/sections" -f $ONuri,  $id
        }
        else {
            $uri = "{0}notebooks/{1}/sections" -f $ONuri,  $id
        }
    }
    $body = New-ONJSONItem -hashtable @{ 'displayname' = $DisplayName }
    Write-Verbose $body
    Get-ONTokenStatus
    $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $accesstoken"} -uri $uri -Method post -Body $body -ContentType "application/json"
    Write-Verbose "Section"
    Return $response

}
