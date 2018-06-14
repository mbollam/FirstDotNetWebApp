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

$TimeStamp = get-date -f yyyy-MM-dd-hhmm
#Start-Transcript -Path D:\Build_Deploy\Logs\STG\UnzipLogs\ConfiguratorLogs\UnzipConfigurator_$TimeStamp.log

$(
cd F:\TextileCare\Trunk\Artifacts\$Environment\
$UnzipLoc = "F:\TextileCare\Trunk\Artifacts\$Environment\jenkins_Configurator"
Remove-Item -Path $UnzipLoc -recurse -force
F:\Build_Deploy\unzip.exe -o "F:\TextileCare\Trunk\Artifacts\$Environment\jenkins_Configurator.zip"
Remove-Item .\jenkins_Configurator.zip
) *>&1 > F:\Build_Deploy\$Environment\Logs\$Environment\UnzipLogs\ConfiguratorLogs\UnzipConfigurator_$TimeStamp.log
#Stop-Transcript

#Transform
cd F:\TextileCare\Trunk\Transformation\
.\TransformWebApp.ps1 -Environment $Environment -TransformFile $TransformFile -ApplicationLocation $ApplicationLocation -Passkey $Passkey

