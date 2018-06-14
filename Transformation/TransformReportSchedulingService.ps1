param(
    [Parameter(Mandatory=$true)]
    [string]$Environment,

    [Parameter(Mandatory=$true)]
    [string]$PackageLocation,

    [Parameter(Mandatory=$true)]
    [string]$Passkey
)

$ErrorActionPreference="Stop"

$transformFile = Join-Path $PSScriptRoot "Transform.ps1"

# Recursively traverses includes from the transformation scripts and fills the collection of nodes.
function Update-Configuration([string]$TransformFileName, [string]$PropertiesFileName) {
    Write-Verbose "Processing configuration file `"$TransformFileName`""
    $input = Get-ChildItem -Path $PackageLocation -Recurse -File -Filter $TransformFileName | Select-Object -First 1
    & $transformFile -InputFile $($input.FullName) -OutputFile $($input.FullName) -Script $(Join-Path $PSScriptRoot "Values\$Environment\$PropertiesFileName") -Passkey $Passkey
}

Update-Configuration -TransformFileName "ReportSchedulingService.exe.config" "Nalco.enVision.ReportScheduling.ReportProcessing.transform.xml"
Write-Output "ReportSchedulingService.exe.config transformation success!"