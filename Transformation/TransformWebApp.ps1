param(
    [Parameter(Mandatory=$true)]
    [string]$Environment,

    [Parameter(Mandatory=$true)]
    [string]$TransformFile,

    [Parameter(Mandatory=$true)]
    [string]$ApplicationLocation,

    [Parameter(Mandatory=$true)]
    [string]$Passkey
)

$ErrorActionPreference="Stop"

$transformScriptFile = Join-Path $PSScriptRoot "Transform.ps1"
$input = Join-Path $ApplicationLocation "Web.config"

& $transformScriptFile -InputFile $input -OutputFile $input -Script $(Join-Path $PSScriptRoot "Values\$Environment\$TransformFile") -Passkey $Passkey

# D:\TCD_Work\Deployment\Transformation\TransformWebApp.ps1 -Environment QA -TransformFile "Web.transform.xml" -ApplicationLocation "D:\Transformation\web_config_file" -Passkey alkdsjlkgajglakdjfg

Write-Output "Web.config transformation success!"