Param(
        [string] $downloadUrlx86 = "https://download.microsoft.com/download/c/6/e/c6e88215-0178-4c6c-b5f3-158ff77b1f38/NetFx20SP2_x86.exe",
        [string] $downloadUrlx64 = "https://download.microsoft.com/download/c/6/e/c6e88215-0178-4c6c-b5f3-158ff77b1f38/NetFx20SP2_x64.exe"
)

#Artifact Log file
$logFile = "NETArtifact.log"

#NET Install log file
$NETlogFile = "NETInstall.log"

$path = Join-path -path $env:ProgramData -childPath "DTLArt_NET20"

if ([environment]::Is64BitOperatingSystem)
{
    $downloadUrl = $downloadUrlx64

}
else
{
    $downloadUrl = $downloadUrlx86
}

#download install file
$downloadFile = "NetFx20SP2.exe"

$localFile = Join-Path $path $downloadFile
$NETLog = Join-Path $path $NETlogFile 
DownloadToFilePath $downloadUrl $localFile

$argumentList = -join (" /q /norestart /log " + $NETLog)

#Run the install and wait for completion.
$retCode = Start-Process -FilePath $localFile -ArgumentList $argumentList -Wait -PassThru

if ($retCode.ExitCode -ne 0)
{
	Write-Output ("NET 2.0 non-zero retcode: " + $retCode.ExitCode.ToString())
    Restart-Computer -Force
}
Write-Output "NET 2.0 install succeeded"
