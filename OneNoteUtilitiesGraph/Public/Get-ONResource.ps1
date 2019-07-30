# Gets the binary data of a file or image resource object
Function Get-ONResource {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Uri,
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    Invoke-RestMethod  -Headers @{Authorization = "Bearer $accesstoken"} -uri $Uri -OutFile $Path
}
