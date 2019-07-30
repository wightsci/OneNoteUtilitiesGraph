
# Get a OneNote Section
Function Get-ONSection {
    Param(
        [Parameter(ParameterSetName='uri',Mandatory=$true)]
        [string]$Uri,
        [Parameter(ParameterSetName='id',ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
        [string]$Id
        )

        if ($uri) {
            Get-ONItem -uri $uri
        }

        if ($Id) {
            Get-ONItem -ItemType 'sections' -Id $Id
        }
}
